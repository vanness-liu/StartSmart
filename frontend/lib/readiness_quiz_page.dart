import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart'; 
import '../providers/quiz_provider.dart';
import 'widgets/quiz_answer_button.dart';
import 'widgets/abandon_dialog.dart';

class ReadinessQuizPage extends StatelessWidget {
  const ReadinessQuizPage({super.key});
  
  // Helper function to show the custom dialog
  Future<bool> _showAbandonDialog(BuildContext context) async {
    final quizProvider = context.read<QuizProvider>(); 
    
    final shouldPop = await showDialog<bool>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext dialogContext) {
        return AbandonDialog(
          onContinue: () {
            Navigator.of(dialogContext).pop(false);
          },
          onLeave: () {
            quizProvider.resetQuiz(); 
            Navigator.of(dialogContext).pop(true);
          },
        );
      },
    );
    // If the dialog is dismissed in some other way, prevent pop
    return shouldPop ?? false; 
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final currentQuestion = quizProvider.currentQuestion;

    if (quizProvider.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: Color(0xFF005C57))),
      );
    }

    // A WillPopScope to handle the user pressing the back button mid-quiz
    return WillPopScope(
      onWillPop: () => _showAbandonDialog(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Readiness Quiz"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () async {
              if (await _showAbandonDialog(context)) {
                Navigator.of(context).pop();
              }
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(),

              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 8.0,
                percent: (quizProvider.currentQuestionIndex + 1) / quizProvider.totalQuestions,
                center: Text(
                  "${quizProvider.currentQuestionIndex + 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFF005C57),
                  ),
                ),
                progressColor: const Color(0xFF005C57),
                backgroundColor: Colors.grey.shade200,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              const SizedBox(height: 48),

              Text(
                currentQuestion.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  height: 1.2,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 48),

              ...currentQuestion.options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: QuizAnswerButton(
                      text: option,
                      onPressed: () {
                        context.read<QuizProvider>().answerQuestion(
                              option,
                              (result) {
                                Navigator.of(context).pop(); 
                              },
                              (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(error)),
                                );
                              },
                            );
                      },
                    ),
                  ),
                );
              }).toList(),
              
              const Spacer(flex: 2), 
            ],
          ),
        ),
      ),
    );
  }
}