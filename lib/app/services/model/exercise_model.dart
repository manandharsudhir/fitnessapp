import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_model.g.dart';

@JsonSerializable()
class ExerciseModel {
  final String id;
  final String gif;
  final String seconds;
  final String thumbnail;
  final String title;

  ExerciseModel({
    @required this.id,
    this.title,
    this.seconds,
    this.gif,
    this.thumbnail,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> exercise) =>
      _$ExerciseModelFromJson(exercise);
  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);
}
