import 'package:flutter/material.dart';
import '../data/quiz_repository.dart';
import '../model/quiz.dart';
import 'screens/welcome_screen.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';

enum QuizState { welcome, question, result }

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  QuizState _currentState = QuizState.welcome;
  late Quiz quiz;
  int currentQuestionIndex = 0;
  List<Answer> _answers = [];

  @override
  void initState() {
    super.initState();
    // Load quiz data from repository
    final repository = QuizMockRepository();
    quiz = repository.getQuiz();
  }

  void _startQuiz() {
    setState(() {
      _currentState = QuizState.question;
      currentQuestionIndex = 0;
      _answers = [];
    });
  }

  void _answerQuestion(String selectedAnswer) {
    // Save the answer
    final answer = Answer(
      questionAnswer: selectedAnswer,
      question: quiz.questions[currentQuestionIndex],
    );
    _answers.add(answer);

    // Check if quiz should end immediately for wrong answer on dismissed question
    if ((answer.question.onDismissed ?? false) && !answer.isCorrect()) {
      setState(() {
        _currentState = QuizState.result;
      });
      return;
    }

    // Move to next question or show results
    if (currentQuestionIndex < quiz.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      setState(() {
        _currentState = QuizState.result;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentState = QuizState.welcome;
      currentQuestionIndex = 0;
      _answers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _buildCurrentScreen(),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    switch (_currentState) {
      case QuizState.welcome:
        return WelcomeScreen(
          quiz: quiz,
          onStartQuiz: _startQuiz,
        );
      case QuizState.question:
        return QuestionScreen(
          question: quiz.questions[currentQuestionIndex],
          questionNumber: currentQuestionIndex + 1,
          totalQuestions: quiz.questions.length,
          onAnswerSelected: _answerQuestion,
        );
      case QuizState.result:
        final submission = Submission(answers: _answers);
        return ResultScreen(
          submission: submission,
          quiz: quiz,
          onRestartQuiz: _restartQuiz,
        );
    }
  }
}
