import 'package:dio/dio.dart';

class GeminiService {
  static const String _apiKey = 'AIzaSyCZ8PS7eR9S77VckuaL4V7ukM2_4cuJFUs'; // Thay bằng key thật
  static const String _url =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$_apiKey';


  final Dio _dio = Dio();

  Future<String?> sendMessage(String message) async {
    try {
      final response = await _dio.post(
        _url,
        data: {
          "contents": [
            {
              "parts": [
                {"text": message}
              ]
            }
          ]
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      final candidates = response.data['candidates'] as List?;
      if (candidates != null && candidates.isNotEmpty) {
        return candidates[0]['content']['parts'][0]['text'];
      }
    } catch (e) {
      print("Gemini error: $e");
    }

    return null;
  }
}
