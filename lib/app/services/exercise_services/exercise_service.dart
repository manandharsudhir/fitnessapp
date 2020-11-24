import 'dart:convert';

import 'package:fitnessapp/app/services/model/exercise_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ExerciseService extends GetxController {
  var isLoading = true.obs;
  var exercises = List<ExerciseModel>().obs;
  var hasError = false.obs;
  @override
  void onInit() {
    findAll();
    super.onInit();
  }

  Future<void> findAll() async {
    try {
      isLoading(true);
      const url = 'https://workout-c291e.firebaseio.com';
      final response = await http.get('$url/exercises.json');
      List<dynamic> _exercises = jsonDecode(response.body) as List;
      exercises.value = _exercises
          .map((exercise) => ExerciseModel.fromJson(exercise))
          .toList();
      hasError(false);
    } catch (error) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }
}
