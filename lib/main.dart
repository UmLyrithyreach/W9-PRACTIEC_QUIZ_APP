import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ui/quiz_app.dart';

void main() => runApp(DevicePreview(builder: (context) => MainApp(), enabled: !kReleaseMode,));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const QuizApp();
  }
}