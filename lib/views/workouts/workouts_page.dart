import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/workout_viewmodel.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/text_constants.dart';
import 'package:gym_power/core/data/workout_data.dart';
import 'package:gym_power/views/workouts/workout_card.dart';

class WorkoutsPage extends GetWidget<WorkoutViewModel> {
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createHomeBody(context),
    );
  }

  Widget _createHomeBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              TextConstants.workouts,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView(
              children: controller.workouts
                  .map((e) => _createWorkoutCard(e))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createWorkoutCard(WorkoutData workoutData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: WorkoutCard(workout: workoutData),
    );
  }
}
