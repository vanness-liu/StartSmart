import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/quiz_models.dart';
import '../services/quiz_api_service.dart';

class QuizProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  // State variables
  int _currentQuestionIndex = 0;
  bool _isLoading = false;
  final List<QuizAnswer> _answers = [];

  // Getters to expose state to the UI
  int get currentQuestionIndex => _currentQuestionIndex;
  bool get isLoading => _isLoading;
  QuizQuestion get currentQuestion => _questions[_currentQuestionIndex];
  int get totalQuestions => _questions.length;

  final List<QuizQuestion> _questions = [
    QuizQuestion(id: 1, text: "Have you identified a specific, real-world problem that your business solves?"),
    QuizQuestion(id: 2, text: "Have you identified your specific target audience and done some research on them?"),
    QuizQuestion(id: 3, text: "Do you know what makes your business idea different or better than existing competitors?"),
    QuizQuestion(id: 4, text: "Have you created a basic budget or financial plan for your startup's first 6-12 months?"),
    QuizQuestion(id: 5, text: "Have you looked into the legal steps required to register your business in Malaysia (e.g., SSM)?"),
    QuizQuestion(id: 6, text: "Do you have a co-founder or key partners who can support your business journey?"),
    QuizQuestion(id: 7, text: "If your idea is unique (e.g., a new app or formula), have you considered how to protect it?"),
  ];

  Future<void> answerQuestion(String answer, Function(QuizResult) onQuizCompleted, Function(String) onError) async {
    _answers.add(QuizAnswer(
        questionId: _questions[_currentQuestionIndex].id, answer: answer));

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      await _submitQuiz(onQuizCompleted, onError);
    }
  }

  Future<void> _submitQuiz(Function(QuizResult) onQuizCompleted, Function(String) onError) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _apiService.evaluateQuiz(_answers);
      final prefs = await SharedPreferences.getInstance();

      final user = FirebaseAuth.instance.currentUser;
      final userKey = user != null ? 'lastQuizResult_${user.uid}' : 'lastQuizResult_guest';
      
      final resultData = result.toJson();
      await prefs.setString(userKey, json.encode(resultData));

      onQuizCompleted(result);
    } catch (e) {
      onError(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _answers.clear();
    _isLoading = false;
    notifyListeners();
  }
}