import 'package:flutter/material.dart';
import '../../model/quiz.dart';
import '../widgets/app_button.dart';

class ResultScreen extends StatelessWidget {
  final Submission submission;
  final Quiz quiz;
  final VoidCallback onRestartQuiz;

  const ResultScreen({
    super.key,
    required this.submission,
    required this.quiz,
    required this.onRestartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    final score = submission.getScore();
    final totalQuestions = submission.getTotalQuestions();
    final percentage = ((score / totalQuestions) * 100).round();
    
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Score Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Score',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$score',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF11998e),
                          ),
                        ),
                        Text(
                          ' / $totalQuestions',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF11998e),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Results breakdown
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Question Results',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      Expanded(
                        child: ListView.builder(
                          itemCount: quiz.questions.length,
                          itemBuilder: (context, index) {
                            final question = quiz.questions[index];
                            final answer = submission.getAnswerFor(question);
                            final isCorrect = answer?.isCorrect() ?? false;
                            
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isCorrect 
                                        ? Colors.green.withOpacity(0.5)
                                        : Colors.red.withOpacity(0.5),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isCorrect ? Icons.check_circle : Icons.cancel,
                                      color: isCorrect ? Colors.green : Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Q${index + 1}: ${question.title}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (!isCorrect) ...[
                                            const SizedBox(height: 4),
                                            Text(
                                              'Correct: ${question.correctAnswer}',
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.7),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // Restart button
              AppButton(
                'Take Quiz Again',
                onTap: onRestartQuiz,
                icon: Icons.refresh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}