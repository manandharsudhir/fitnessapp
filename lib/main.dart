import 'package:fitnessapp/ui/exercise_view.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExerciseView(),
      navigatorKey: Get.key,
    );
  }
}
