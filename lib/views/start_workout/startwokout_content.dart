import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/workout_viewmodel.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/path_constants.dart';
import 'package:gym_power/core/const/text_constants.dart';
import 'package:gym_power/core/data/exercise_data.dart';
import 'package:gym_power/core/data/workout_data.dart';
import 'package:gym_power/core/services/data_service.dart';
import 'package:gym_power/views/start_workout/start_workout_video.dart';
import 'package:gym_power/views/widgets/fitness_button.dart';

class StartWorkoutContent extends GetWidget<WorkoutViewModel> {
  final ExerciseData exercise;
  final ExerciseData? nextExercise;

  StartWorkoutContent({required this.exercise, required this.nextExercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: SafeArea(
        child: _createDetailedExercise(context),
      ),
    );
  }

  Widget _createDetailedExercise(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createBackButton(context),
          const SizedBox(height: 23),
          _createVideo(context),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(children: [
              _createTitle(),
              const SizedBox(height: 9),
              _createDescription(),
              const SizedBox(height: 30),
              _createSteps(),
            ]),
          ),
          _createTimeTracker(context),
        ],
      ),
    );
  }

  Widget _createBackButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 8),
      child: GestureDetector(
        child: Row(
          children: [
            Image(image: AssetImage(PathConstants.back)),
            const SizedBox(width: 17),
            Text(
              TextConstants.back,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        onTap: () {
          // bloc.add(BackTappedEvent());
        },
      ),
    );
  }

  Widget _createVideo(BuildContext context) {
    return Container(
      height: 264,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: ColorConstants.white),
      child: StartWorkoutVideo(
        exercise: exercise,
        onPlayTapped: (time) async {
          // bloc.add(PlayTappedEvent(time: time));
        },
        onPauseTapped: (time) {
          // bloc.add(PauseTappedEvent(time: time));
        },
      ),
    );
  }

  Widget _createTitle() {
    return Text(exercise.title ?? "",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
  }

  Widget _createDescription() {
    return Text(exercise.description ?? "",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500));
  }

  Widget _createSteps() {
    return Column(
      children: [
        for (int i = 0; i < exercise.steps!.length; i++) ...[
          Step(number: "${i + 1}", description: exercise.steps![i]),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _createTimeTracker(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorConstants.white,
      child: Column(
        children: [
          nextExercise != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TextConstants.nextExercise,
                      style: TextStyle(
                        color: ColorConstants.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      nextExercise?.title ?? "",
                      style: TextStyle(
                        color: ColorConstants.textBlack,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6.5),
                    Icon(Icons.access_time, size: 20),
                    const SizedBox(width: 6.5),
                    Text(
                        '${nextExercise!.minutes! > 10 ? nextExercise!.minutes : '0${nextExercise!.minutes}'}:00')
                    // BlocBuilder<StartWorkoutBloc, StartWorkoutState>(
                    //   buildWhen: (_, currState) => currState is PlayTimerState || currState is PauseTimerState,
                    //   builder: (context, state) {
                    //     return StartWorkoutTimer(
                    //       time: bloc.time,
                    //       isPaused: !(state is PlayTimerState),
                    //     );
                    //   },
                    // ),
                  ],
                )
              : SizedBox.shrink(),
          const SizedBox(height: 18),
          _createButton(context),
        ],
      ),
    );
  }

  Widget _createButton(BuildContext context) {
    return FitnessButton(
      title: nextExercise != null ? TextConstants.next : TextConstants.finished,
      onTap: () async {
        if (nextExercise != null) {
          List<ExerciseData>? exercisesList =
              Get.find<WorkoutViewModel>().workout.exerciseDataList;
          int currentExerciseIndex = exercisesList!.indexOf(exercise);

          await _saveWorkout(currentExerciseIndex);

          if (currentExerciseIndex < exercisesList.length - 1) {
            // bloc.add(workout_bloc.StartTappedEvent(
            //   workout: workout,
            //   index: currentExerciseIndex + 1,
            //   isReplace: true,
            // )
            // );
          }
        } else {
          await _saveWorkout(controller.workout.exerciseDataList!.length - 1);

          Navigator.pop(context, controller.workout);
        }
      },
    );
  }

  Future<void> _saveWorkout(int exerciseIndex) async {
    if (controller.workout.currentProgress! < exerciseIndex + 1) {
      controller.workout.currentProgress = exerciseIndex + 1;
    }
    controller.workout.exerciseDataList![exerciseIndex].progress = 1;

    await DataService.saveWorkout(controller.workout);
  }
}

class Step extends StatelessWidget {
  final String number;
  final String description;

  Step({required this.number, required this.description});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConstants.primaryColor.withOpacity(0.12),
          ),
          child: Center(
              child: Text(number,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primaryColor))),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(description)),
      ],
    );
  }
}
