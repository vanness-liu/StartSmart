import 'package:flutter/material.dart';

class QuizAnswerButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const QuizAnswerButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  State<QuizAnswerButton> createState() => _QuizAnswerButtonState();
}

class _QuizAnswerButtonState extends State<QuizAnswerButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // GestureDetector detects tap-down and tap-up events
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        // Call the original onPressed callback
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9), // A slightly different light green
          borderRadius: BorderRadius.circular(30),
          boxShadow: _isPressed
              ? [] // No shadow when pressed down
              : [
                  // Shadow gives the "elevated" 3D look
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF005C57),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}