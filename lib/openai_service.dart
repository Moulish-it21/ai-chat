import 'package:dio/dio.dart' as http;

class OpenAIService {
     Future<String> isArtPromptAPI(String prompt) async {
        try{
           http.post()
        } catch (e) {
          return e.toString();
        }
     }
     Future<String> chatGPTAPI(String prompt) async {
          return 'CHATGPT';
     }
     Future<String> dallEAPI(String prompt) async {
          return 'DALL-E';
     }

}