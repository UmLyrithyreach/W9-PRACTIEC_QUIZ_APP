import '../model/quiz.dart';

abstract class QuizRepository {
  Quiz getQuiz();
}

class QuizMockRepository implements QuizRepository {
  @override
  Quiz getQuiz() {
    return const Quiz(
      title: "Flutter Quiz",
      questions: [
        Question(
          title: "Who's the best teacher?",
          possibleAnswers: [
            "Ronan Orgor",
            "Leangsiv",
            "Hongly"
          ],
          correctAnswer: "Ronan Orgor",
          onDismissed: true,
        ),
        Question(
          title: "Which programming language is used in Flutter?",
          possibleAnswers: [
            "Java",
            "Kotlin",
            "Dart",
            "Swift"
          ],
          correctAnswer: "Dart",
        ),
        Question(
          title: "What is a Widget in Flutter?",
          possibleAnswers: [
            "A small application",
            "A UI component",
            "A database table",
            "A programming function"
          ],
          correctAnswer: "A UI component",
        ),
        Question(
          title: "Which company developed Flutter?",
          possibleAnswers: [
            "Apple",
            "Microsoft",
            "Google",
            "Facebook"
          ],
          correctAnswer: "Google",
        ),
        Question(
          title: "What is the main advantage of Flutter?",
          possibleAnswers: [
            "Only works on iOS",
            "Cross-platform development",
            "Only for web development",
            "Requires separate code for each platform"
          ],
          correctAnswer: "Cross-platform development",
        ),
      ],
    );
  }
}