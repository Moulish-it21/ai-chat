import 'package:chatgpt_assistant/feature_box.dart';
import 'package:chatgpt_assistant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();
  String lastWords = '';
  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async{
    await speechToText.initialize();
    setState(() {});
  }


  Future<void> startListening() async {
    await speechToText.listen(onResult:  onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }


  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anderson'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 124,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('assets/images/VirtualAssistant.png',
                    ),
                    ),
                  ),
                ),
              ],
            ),
            //Chat Bubble
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 40,).copyWith(
                top: 30,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),
              ),
              child: const Padding(
                padding:  EdgeInsets.symmetric(vertical:10.0 ),
                child:  Text(
                  'Good Morning, what task can I do for you?',
                    style: TextStyle(
                      fontFamily: 'Cera Pro',
                     color: Pallete.mainFontColor,
                      fontSize: 20,
                    ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  top: 10,
                  left: 22
              ),
              child: const Text('Here are a few features',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
            //features List
            Column(
              children: [
                //ChatGPT
                FeatureBox(
                    color: Pallete.firstSuggestionBoxColor,
                     headerText: 'ChatGPT',
                     descriptionText: 'A smarter way to stay organized and informed with ChatGPT',
                ),

                //Dall-E
                FeatureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  headerText: 'Dall-E',
                  descriptionText: 'Get inspired and stay creative with your personal assistant powered by Dall-E',
                ),

                //Smart Voice Assistant
                FeatureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  headerText: 'Smart Voice Assistant',
                  descriptionText: 'Get the beat of both worlds with a voice assistant powered by  Dall-E and ChatGPT',
                ),

              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
      backgroundColor: Pallete.secondSuggestionBoxColor,
        onPressed: ()async{
        if(await speechToText.hasPermission &&
            speechToText.isNotListening) {
          await startListening();
        } else if(speechToText.isListening){
          await stopListening();
        } else{
          initSpeechToText();
        }

      },

      child: const Icon(
          Icons.mic,
      ) ,
      ),
    );
  }
}
