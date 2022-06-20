import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/workout_viewmodel.dart';
import 'package:gym_power/core/const/text_constants.dart';
import 'package:gym_power/core/data/exercise_data.dart';
import 'package:gym_power/core/data/workout_data.dart';
import 'package:gym_power/views/start_workout/start_workout_page.dart';
import 'package:gym_power/views/widgets/fitness_button.dart';
import 'package:gym_power/views/workout_details/workout_details_content.dart';

class WorkoutDetails extends GetWidget<WorkoutViewModel> {
  final WorkoutData workout;

  const WorkoutDetails({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FitnessButton(
          title: TextConstants.start,
          onTap: () {
            ExerciseData? exercise = workout.exerciseDataList
                ?.firstWhere((element) => element.progress! < 1);
            if (exercise == null) exercise = workout.exerciseDataList?.first;
            int? exerciseIndex = workout.exerciseDataList?.indexOf(exercise!);
            Get.to(
              () => StartWorkoutPage(
                exercise: exercise!,
                currentExercise: exercise,
                nextExercise:
                    exerciseIndex! + 1 < (workout.exerciseDataList?.length)!
                        ? workout.exerciseDataList![exerciseIndex + 1]
                        : null,
              ),
            );
          },
        ),
      ),
      body: WorkoutDetailsContent(workout: workout),
    );
  }
}
