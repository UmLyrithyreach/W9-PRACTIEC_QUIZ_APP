import 'package:flutter/material.dart';
 
class QuizApp extends StatefulWidget {
  const QuizApp( {super.key});


  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('TODO !'),
            ],
          ),
        ),
      ),
    );
  }
}
