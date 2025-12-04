# Quiz App - Reflection Analysis

This document addresses the reflection questions from the homework assignment.

## PART 1 – REFLECTIONS

### MODEL

#### Q1 – UML Diagram of the Model

```
┌─────────────────┐
│      Quiz       │
├─────────────────┤
│ - title: String │
│ - questions: List<Question> │
└─────────────────┘
         │
         │ 1..*
         ▼
┌─────────────────────────┐
│       Question          │
├─────────────────────────┤
│ - title: String         │
│ - possibleAnswers: List<String> │
│ - correctAnswer: String │
├─────────────────────────┤
│ + isCorrectAnswer(String): bool │
└─────────────────────────┘
         │
         │ 1..1
         ▼
┌─────────────────────────┐
│        Answer           │
├─────────────────────────┤
│ - questionAnswer: String│
│ - question: Question    │
├─────────────────────────┤
│ + isCorrect(): bool     │
└─────────────────────────┘
         │
         │ *
         ▼
┌─────────────────────────┐
│      Submission         │
├─────────────────────────┤
│ - answers: List<Answer> │
├─────────────────────────┤
│ + getScore(): int       │
│ + getCorrectAnswers(): int │
│ + getTotalQuestions(): int │
│ + getAnswerFor(Question): Answer? │
└─────────────────────────┘
```

#### Q2 – Where do you keep player submission?

Player submissions are kept in the `Submission` class which contains a list of `Answer` objects. Each `Answer` links a user's selected answer to a specific question. This design allows us to:

- Track all user responses
- Calculate the final score
- Display detailed results showing correct/incorrect answers
- Maintain the relationship between questions and user responses

The submission is managed in the main `QuizApp` state as `List<Answer> _answers` and converted to a `Submission` object when displaying results.

### UI – Screens

#### Q3 – Widget Properties

| WIDGET | TYPE (SL/SF) | PARAMETERS | STATES |
|--------|--------------|------------|--------|
| WelcomeScreen | SL | quiz: Quiz, onStartQuiz: VoidCallback | None |
| QuestionScreen | SF | question: Question, questionNumber: int, totalQuestions: int, onAnswerSelected: Function(String) | _selectedAnswer: String? |
| ResultScreen | SL | submission: Submission, quiz: Quiz, onRestartQuiz: VoidCallback | None |
| QuizApp | SF | None | _currentState: QuizState, _quiz: Quiz, _currentQuestionIndex: int, _answers: List<Answer> |

**Legend:**
- SL = StatelessWidget
- SF = StatefulWidget

#### Q4 – Component Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                        QuizApp (SF)                         │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ State Management:                                       ││
│  │ - _currentState: QuizState                              ││
│  │ - _quiz: Quiz                                           ││
│  │ - _currentQuestionIndex: int                            ││
│  │ - _answers: List<Answer>                                ││
│  └─────────────────────────────────────────────────────────┘│
│                              │                              │
│              ┌───────────────┼───────────────┐              │
│              ▼               ▼               ▼              │
│  ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐│
│  │ WelcomeScreen   │ │ QuestionScreen  │ │ ResultScreen    ││
│  │     (SL)        │ │     (SF)        │ │     (SL)        ││
│  └─────────────────┘ └─────────────────┘ └─────────────────┘│
│              │               │               │              │
│              └───────────────┼───────────────┘              │
│                              ▼                              │
│                  ┌─────────────────┐                        │
│                  │   AppButton     │                        │
│                  │     (SL)        │                        │
│                  └─────────────────┘                        │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Data Layer                               │
│  ┌─────────────────┐                ┌─────────────────┐     │
│  │ QuizRepository  │◄──implements───│QuizMockRepository│     │
│  │   (Abstract)    │                │                 │     │
│  └─────────────────┘                └─────────────────┘     │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Domain Models                            │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────────┐       │
│  │  Quiz   │ │Question │ │ Answer  │ │ Submission  │       │
│  └─────────┘ └─────────┘ └─────────┘ └─────────────┘       │
└─────────────────────────────────────────────────────────────┘
```

#### Q5 – Navigation Management

Navigation is managed in the `QuizApp` widget using:

1. **State Enum**: `QuizState { welcome, question, result }`
2. **State Variable**: `_currentState` tracks the current screen
3. **Navigation Methods**:
   - `_startQuiz()`: Transitions from welcome to question screen
   - `_answerQuestion(String)`: Handles answer submission and moves to next question or results
   - `_restartQuiz()`: Returns to welcome screen

The navigation logic is centralized in the `_buildCurrentScreen()` method which returns the appropriate widget based on the current state.

### UI – Reusable Widgets

| WIDGET | TYPE (SL/SF) | PARAMETERS | STATES |
|--------|--------------|------------|--------|
| AppButton | SL | label: String, onTap: VoidCallback, icon: IconData? | None |

The `AppButton` is designed to be reusable across all screens with consistent styling and optional icon support.

## PART 2 – IMPLEMENTATION

### Architecture Implementation

The application follows the required 3-layer architecture:

1. **DATA Layer** (`lib/data/`):
   - `QuizRepository`: Abstract interface
   - `QuizMockRepository`: Concrete implementation with sample data

2. **DOMAIN Layer** (`lib/model/`):
   - Domain classes: `Quiz`, `Question`, `Answer`, `Submission`
   - Business logic encapsulated in model methods

3. **UI Layer** (`lib/ui/`):
   - `screens/`: Screen widgets for different app states
   - `widgets/`: Reusable UI components
   - Clean separation from business logic

### Key Design Decisions

1. **State Management**: Used StatefulWidget for simplicity as required (no router)
2. **Data Flow**: Unidirectional data flow from repository → app state → screens
3. **Separation of Concerns**: UI components receive data as parameters, business logic in models
4. **Reusability**: Common widgets extracted for reuse across screens

### Features Implemented

- ✅ Single choice questions with radio button-like selection
- ✅ Progress indicator showing current question number and percentage
- ✅ Score calculation and display
- ✅ Detailed results showing correct/incorrect answers
- ✅ Restart functionality
- ✅ Responsive design with gradient backgrounds
- ✅ Clean architecture following assignment requirements

This implementation demonstrates proper separation of concerns, clean architecture principles, and meets all the functional requirements specified in the assignment.