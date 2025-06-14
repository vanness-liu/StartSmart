import 'dart:convert';
import 'dart:io' show Platform; 
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb; 

class ChatApiService {
  String get _baseUrl {
    if (kIsWeb) {
      // Running on the web
      return "http://127.0.0.1:8000/api/chat";   //"http://localhost:8000/api/chat"
    }
    
    // Check if running on Android
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8000/api/chat";
    } 
    // Check if running on iOS
    else if (Platform.isIOS) {
       return "http://localhost:8000/api/chat"; 
    }
    else {
      // Fallback for other platforms like desktop
      return "http://localhost:8000/api/chat";
    }
  }

  Future<String> sendMessage({
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