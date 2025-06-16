import 'package:flutter/material.dart';

class AbandonDialog extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onLeave;

  const AbandonDialog({
    super.key,
    required this.onContinue,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: <Widget>[
          const Text(
            "Abandon attempt?",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            "It seems that you are clicking away while attempting this quiz. Are you sure you want to leave?",
            style: TextStyle(fontSize: 16.0, color: Colors.black, height: 1.2),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          // "Continue" Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 49, 170, 97), // Main green color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          // "Leave" Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onLeave,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFE57373), // Red color for text and border
                side: const BorderSide(color: Color(0xFFE57373), width: 2),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Leave',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}