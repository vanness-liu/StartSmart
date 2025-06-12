// frontend/lib/quiz_launcher_page.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'models/quiz_models.dart';
import 'quiz_results_page.dart';
import 'readiness_quiz_page.dart';

class QuizLauncherPage extends StatefulWidget {
  const QuizLauncherPage({super.key});

  @override
  State<QuizLauncherPage> createState() => _QuizLauncherPageState();
}

class _QuizLauncherPageState extends State<QuizLauncherPage> {
  late Future<QuizResult?> _lastResultFuture;

  @override
  void initState() {
    super.initState();
    _lastResultFuture = _getLastResult();
  }

  Future<QuizResult?> _getLastResult() async {
    final prefs = await SharedPreferences.getInstance();
    final resultString = prefs.getString('lastQuizResult');
    if (resultString != null) {
      return QuizResult.fromJson(json.decode(resultString));
    }
    return null;
  }

  void refreshLauncher() {
    setState(() {
      _lastResultFuture = _getLastResult();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuizResult?>(
      future: _lastResultFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data != null) {
          return QuizResultsContent(
            result: snapshot.data!,
            onReattempt: refreshLauncher,
          );
        } else {
          return buildStartQuizPage(context);
        }
      },
    );
  }

  Widget buildStartQuizPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),

          // Main Title
          const Text(
            "Are you ready to build your empire?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),

          const SizedBox(height: 24),
          Image.asset(
            'assets/rocket.png', 
            height: 250,
          ),
          const SizedBox(height: 24),

          // Description Text
          const Text(
            "Answer a few questions and we'll let you know if you're prepared to take on the startup world!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black, height: 1.2),
          ),

          const SizedBox(height: 32),

          // "Try Now" Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                    MaterialPageRoute(
                      builder: (_) => const ReadinessQuizPage(),
                    ),
                  )
                  .then((_) {
                    refreshLauncher();
                  });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(
                0xFF004D40,
              ), // A slightly darker, richer green
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Try Now!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
