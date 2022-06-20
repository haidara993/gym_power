import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/workout_viewmodel.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/text_constants.dart';
import 'package:gym_power/core/data/workout_data.dart';
import 'package:gym_power/views/workout_details/workout_details.dart';
import 'package:percent_indicator/percent_indicator.dart';

class WorkoutCard extends StatelessWidget {
  final WorkoutData workout;
  WorkoutCard({Key? key, required this.workout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
              color: ColorConstants.textBlack.withOpacity(0.12),
              blurRadius: 5.0,
              spreadRadius: 1.1)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: GetBuilder<WorkoutViewModel>(
          builder: (controller) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Get.to(() => WorkoutDetails(workout: workout));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(workout.title!,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 3),
                          Text(
                              workout.exercises! +
                                  " " +
                                  TextConstants.exercisesUppercase,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                          const SizedBox(height: 3),
                          Text(workout.minutes! + " " + TextConstants.minutes,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstants.grey),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                          Spacer(),
                          Text('${workout.currentProgress}/${workout.progress}',
                              style: TextStyle(fontSize: 10)),
                          SizedBox(height: 3),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 30.0, left: 2),
                            child: LinearPercentIndicator(
                              percent:
                                  workout.currentProgress! / workout.progress!,
                              progressColor: ColorConstants.primaryColor,
                              backgroundColor:
                                  ColorConstants.primaryColor.withOpacity(0.12),
                              lineHeight: 6,
                              padding: EdgeInsets.zero,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 60),
                    Expanded(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child:
                                Image.asset(workout.image!, fit: BoxFit.fill))),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
