// frontend/lib/services/api_service.dart

import 'dart:convert';
import 'dart:io' show Platform; 
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb; 
import '../models/quiz_models.dart';

class ApiService {
  String get _baseUrl {
    if (kIsWeb) {
      // Running on the web
      return "http://localhost:8000/api/v1";
    }
    
    // Check if running on Android
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8000/api/v1";
    } 
    // Check if running on iOS
    else if (Platform.isIOS) {
       return "http://localhost:8000/api/v1"; 
    }
    else {
      // Fallback for other platforms like desktop
      return "http://localhost:8000/api/v1";
    }
  }

  Future<QuizResult> evaluateQuiz(List<QuizAnswer> answers) async {
    // The final endpoint is now /quiz/evaluate
    final url = Uri.parse('$_baseUrl/quiz/evaluate'); 
    
    final body = json.encode({
      'answers': answers.map((a) => a.toJson()).toList(),
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        return QuizResult.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to evaluate quiz. Server returned status: ${response.statusCode} on URL: $url');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server at $url. Please check your network and backend status.');
    }
  }
}