import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/workout_viewmodel.dart';
import 'package:gym_power/core/data/exercise_data.dart';
import 'package:gym_power/core/data/workout_data.dart';
import 'package:gym_power/views/start_workout/startwokout_content.dart';

class StartWorkoutPage extends StatelessWidget {
  final ExerciseData exercise;
  final ExerciseData currentExercise;
  final ExerciseData? nextExercise;

  StartWorkoutPage(
      {required this.exercise,
      required this.currentExercise,
      required this.nextExercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WorkoutViewModel>(
        builder: (controller) {
          return StartWorkoutContent(
            exercise: exercise,
            nextExercise: nextExercise,
          );
        },
      ),
    );
  }
}
