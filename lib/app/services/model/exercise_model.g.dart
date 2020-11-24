// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) {
  return ExerciseModel(
    id: json['id'] as String,
    title: json['title'] as String,
    seconds: json['seconds'] as String,
    gif: json['gif'] as String,
    thumbnail: json['thumbnail'] as String,
  );
}

Map<String, dynamic> _$ExerciseModelToJson(ExerciseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gif': instance.gif,
      'seconds': instance.seconds,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
    };
