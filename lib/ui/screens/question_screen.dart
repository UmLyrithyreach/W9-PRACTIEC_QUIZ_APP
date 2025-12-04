import 'package:flutter/material.dart';
import '../../model/quiz.dart';

class QuestionScreen extends StatefulWidget {
  final Question question;
  final int questionNumber;
  final int totalQuestions;
  final Function(String) onAnswerSelected;

  const QuestionScreen({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.onAnswerSelected,
  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String? selectedAnswer;

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [  
               // Question card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      textAlign: TextAlign.center,
                      widget.question.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Spacer to center answers
              const Spacer(),
              
              // Answer options
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.question.possibleAnswers.length,
                itemBuilder: (context, index) {
                  final answer = widget.question.possibleAnswers[index];
                  final isSelected = selectedAnswer == answer;
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAnswer = answer;
                        });
                        widget.onAnswerSelected(selectedAnswer!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? Colors.white 
                              : Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected 
                                ? const Color(0xFF667eea)
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Removed circular indicator
                            Expanded(
                              child: Text(
                                answer,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: isSelected 
                                      ? FontWeight.w600 
                                      : FontWeight.w400,
                                  color: const Color(0xFF2D3748),
                                ),
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check,
                                color: Color(0xFF667eea),
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              // Spacer to center answers
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}