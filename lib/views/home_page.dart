import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/auth_viewmodel.dart';
import 'package:gym_power/controllers/control_viewmodel.dart';
import 'package:gym_power/controllers/home_viewmodel.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/data_constants.dart';
import 'package:gym_power/core/const/path_constants.dart';
import 'package:gym_power/core/const/text_constants.dart';
import 'package:gym_power/views/homescreens/home_statistics.dart';
import 'package:gym_power/views/widgets/fitness_button.dart';
import 'package:gym_power/views/workout_details/workout_details.dart';
import 'package:gym_power/views/workouts/workout_card.dart';

class HomePage extends GetWidget<HomeViewModel> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          children: [
            _createProfileData(context),
            const SizedBox(height: 35),
            _showStartWorkout(context),
            const SizedBox(height: 30),
            _createExercisesList(context),
            const SizedBox(height: 25),
            _createProgress(),
          ],
        ),
      ),
    );
  }

  Widget _createProfileData(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<HomeViewModel>(
        builder: (controller) {
          final photoURL = controller.photoURL;
          final displayName = controller.displayName;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, $displayName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    TextConstants.checkActivity,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                child: photoURL == null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(PathConstants.profile),
                        radius: 25)
                    : CircleAvatar(
                        child: ClipOval(
                            child: FadeInImage.assetNetwork(
                                placeholder: PathConstants.profile,
                                image: photoURL,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 120)),
                        radius: 25),
                onTap: () async {
                  // await Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (_) => EditAccountScreen()));
                  // BlocProvider.of<HomeBloc>(context).add(ReloadImageEvent());
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _showStartWorkout(BuildContext context) {
    return controller.workouts.isEmpty
        ? _createStartWorkout(context)
        : HomeStatistics();
  }

  Widget _createStartWorkout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.textBlack.withOpacity(0.12),
            blurRadius: 5.0,
            spreadRadius: 1.1,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(PathConstants.home),
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 10),
              Text(TextConstants.homeIcon,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
            ],
          ),
          const SizedBox(height: 16),
          Text("sportActivity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text("signToStart",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.textGrey)),
          const SizedBox(height: 24),
          FitnessButton(
            title: "startWorkout",
            onTap: () {
              Get.find<ControlViewModel>().changeSelectedValue(1);
            },
          ),
        ],
      ),
    );
  }

  Widget _createExercisesList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            TextConstants.discoverWorkouts,
            style: TextStyle(
              color: ColorConstants.textBlack,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 20),
              // WorkoutCard(
              //   // color: ColorConstants.cardioColor,
              //   workout: DataConstants.workouts[0],
              //   // onTap: () => Navigator.of(context).push(MaterialPageRoute(
              //   //     builder: (_) => WorkoutDetails(
              //   //         workout: DataConstants.workouts[0]),),),
              // ),
              const SizedBox(width: 15),
              // WorkoutCard(
              //   // color: ColorConstants.armsColor,
              //   workout: DataConstants.workouts[2],
              //   // onTap: () => Navigator.of(context).push(
              //   //   MaterialPageRoute(
              //   //     builder: (_) => WorkoutDetails(
              //   //       workout: DataConstants.workouts[2],
              //   //     ),
              //   //   ),
              //   // ),
              // ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showProgress() {
    return controller.workouts.isNotEmpty ? _createProgress() : Container();
  }

  Widget _createProgress() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.white,
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
          Image(image: AssetImage(PathConstants.progress)),
          SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TextConstants.keepProgress,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(
                  '${TextConstants.profileSuccessful} ${controller.percent}% of workouts.',
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
