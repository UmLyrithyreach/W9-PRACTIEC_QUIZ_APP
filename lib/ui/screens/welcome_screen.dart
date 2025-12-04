import 'package:flutter/material.dart';
import '../../model/quiz.dart';
import '../widgets/app_button.dart';

class WelcomeScreen extends StatelessWidget {
  final Quiz quiz;
  final VoidCallback onStartQuiz;

  const WelcomeScreen({
    super.key,
    required this.quiz,
    required this.onStartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Quiz Logo
              Image.asset("assets/quiz-logo.png"),
              
              // Quiz Title
              Text(
                quiz.title,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              
              // Start Button
              AppButton(
                'Start Quiz',
                onTap: onStartQuiz,
                icon: Icons.play_arrow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
