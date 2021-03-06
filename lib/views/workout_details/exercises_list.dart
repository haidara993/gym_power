import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/path_constants.dart';
import 'package:gym_power/core/data/exercise_data.dart';
import 'package:gym_power/core/data/workout_data.dart';
import 'package:gym_power/views/start_workout/start_workout_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExercisesList extends StatelessWidget {
  final WorkoutData workout;
  final List<ExerciseData> exercises;

  const ExercisesList({required this.exercises, required this.workout});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 10),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseCell(
          currentExercise: exercises[index],
          nextExercise:
              index == exercises.length - 1 ? null : exercises[index + 1],
          workout: workout,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }
}

class ExerciseCell extends StatelessWidget {
  final WorkoutData workout;
  final ExerciseData currentExercise;
  final ExerciseData? nextExercise;

  const ExerciseCell({
    required this.currentExercise,
    required this.workout,
    required this.nextExercise,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        print("hjk");
        ExerciseData? exercise = workout.exerciseDataList
            ?.firstWhere((element) => element.progress! < 1);
        if (exercise == null) exercise = workout.exerciseDataList?.first;
        int? exerciseIndex = workout.exerciseDataList?.indexOf(exercise!);
        Get.to(
          () => StartWorkoutPage(
              exercise: currentExercise,
              currentExercise: currentExercise,
              nextExercise: nextExercise),
        );
      },
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 10, right: 25, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.textBlack.withOpacity(0.12),
              blurRadius: 5.0,
              spreadRadius: 1.1,
            ),
          ],
        ),
        child: Row(
          children: [
            _createImage(),
            const SizedBox(width: 10),
            Expanded(
              child: _createExerciseTextInfo(),
            ),
            const SizedBox(width: 10),
            _createRightArrow(),
          ],
        ),
      ),
    );
  }

  Widget _createImage() {
    return Container(
      width: 75,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage(workout.image!),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _createExerciseTextInfo() {
    final minutesStr = "${currentExercise.minutes} minutes";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentExercise.title!,
          style: TextStyle(
            color: ColorConstants.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          minutesStr,
          style: TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 11),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: LinearPercentIndicator(
            percent: currentExercise.progress!,
            progressColor: ColorConstants.primaryColor,
            backgroundColor: ColorConstants.primaryColor.withOpacity(0.12),
            lineHeight: 6,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _createRightArrow() {
    return RotatedBox(
      quarterTurns: 2,
      child: Image(
        image: AssetImage(PathConstants.back),
      ),
    );
  }
}
