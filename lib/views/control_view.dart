import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/controllers/auth_viewmodel.dart';
import 'package:gym_power/controllers/control_viewmodel.dart';
import 'package:gym_power/controllers/network_viewmodel.dart';
import 'package:gym_power/core/const/color_constant.dart';
import 'package:gym_power/core/const/path_constants.dart';
import 'package:gym_power/core/const/text_constants.dart';
import 'package:gym_power/views/onboarding/onboarding_page.dart';
import 'package:gym_power/views/sign_up/sign_up_page.dart';
import 'package:gym_power/views/widgets/custom_text.dart';

class ControlView extends GetWidget<AuthViewModel> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return (Get.find<AuthViewModel>().user == null)
            ? SignUpPage()
            : Get.find<NetworkViewModel>().connectionStatus == 1 ||
                    Get.find<NetworkViewModel>().connectionStatus == 2
                ? GetBuilder<ControlViewModel>(
                    init: ControlViewModel(),
                    builder: (controller) {
                      return Scaffold(
                        body: controller.currentScreen,
                        bottomNavigationBar: _createdBottomTabBar(context),
                      );
                    })
                : NoInternetConnection();
      },
    );
  }

  Widget _createdBottomTabBar(BuildContext context) {
    return GetBuilder<ControlViewModel>(builder: (controller) {
      return BottomNavigationBar(
        currentIndex: controller.navigatorValue,
        fixedColor: ColorConstants.primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(PathConstants.home),
              color: controller.navigatorValue == 0
                  ? ColorConstants.primaryColor
                  : null,
            ),
            label: TextConstants.homeIcon,
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(PathConstants.workouts),
              color: controller.navigatorValue == 1
                  ? ColorConstants.primaryColor
                  : null,
            ),
            label: TextConstants.workoutsIcon,
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage(PathConstants.settings),
              color: controller.navigatorValue == 2
                  ? ColorConstants.primaryColor
                  : null,
            ),
            label: TextConstants.settingsIcon,
          ),
        ],
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
      );
    });
  }
}

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            CustomText(
              text: 'Please check your internet connection..',
              fontSize: 16,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
