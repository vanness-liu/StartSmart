import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatApiService {
  static const String _baseUrl = "http://10.0.2.2:8000/api/chat"; // Change if needed

  static Future<String> sendMessage({
    required String question,
    required String industry,
    required String experience,
    required String phase,
    required String launchTime,
    required String funding,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'question': question,
        'industry': industry,
        'experience': experience,
        'phase': phase,
        'launch_time': launchTime,
        'funding': funding,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['answer'] ?? "No answer received.";
    } else {
      throw Exception('Failed to get response from chat API');
    }
  }
}