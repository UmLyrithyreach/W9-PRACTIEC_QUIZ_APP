class Quiz {
  final String title;
  final List<Question> questions;

  const Quiz({
    required this.title,
    required this.questions,
  });
}

class Question {
  final String title;
  final List<String> possibleAnswers;
  final String correctAnswer;
  final bool? onDismissed;

  const Question({
    required this.title,
    required this.possibleAnswers,
    required this.correctAnswer,
    bool? onDismissed,
  }) : onDismissed = onDismissed ?? false;

  bool isCorrectAnswer(String answer) {
    return answer == correctAnswer;
  }
}

class Answer {
  final String questionAnswer;
  final Question question;

  const Answer({
    required this.questionAnswer,
    required this.question,
  });

  bool isCorrect() {
    return question.isCorrectAnswer(questionAnswer);
  }
}

class Submission {
  final List<Answer> answers;

  const Submission({
    required this.answers,
  });

  int getScore() {
    int score = 0;
    for (Answer answer in answers) {
      if (answer.isCorrect()) {
        score++;
      }
    }
    return score;
  }

  int getCorrectAnswers() {
    return getScore();
  }

  int getTotalQuestions() {
    return answers.length;
  }

  Answer? getAnswerFor(Question question) {
    for (Answer answer in answers) {
      if (answer.question == question) {
        return answer;
      }
    }
    return null;
  }
}