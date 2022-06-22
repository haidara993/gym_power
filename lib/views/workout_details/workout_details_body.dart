import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/path_constants.dart';
import 'package:gym_power/core/data/workout_data.dart';

class WorkoutDetailsBody extends StatelessWidget {
  final WorkoutData workout;
  WorkoutDetailsBody({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createImage(),
          _createBackButton(context),
        ],
      ),
    );
  }

  Widget _createBackButton(BuildContext context) {
    return Positioned(
      child: SafeArea(
        child: GestureDetector(
          child: Container(
            width: 30,
            height: 30,
            child: Image(
              image: AssetImage(PathConstants.back),
            ),
          ),
          onTap: () {
            Get.back();
          },
        ),
      ),
      left: 20,
      top: 14,
    );
  }

  Widget _createImage() {
    return Container(
      width: double.infinity,
      child: Image(
        image: AssetImage(workout.image!),
        fit: BoxFit.cover,
      ),
    );
  }
}
