import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_power/views/home_page.dart';
import 'package:gym_power/views/settings/settings_page.dart';
import 'package:gym_power/views/workouts/workouts_page.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  Widget _currentScreen = HomePage();

  get currentScreen => _currentScreen;
  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          _currentScreen = HomePage();
          break;
        }
      case 1:
        {
          _currentScreen = WorkoutsPage();
          break;
        }
      case 2:
        {
          _currentScreen = SettingsPage();
          break;
        }
    }
    update();
  }
}
