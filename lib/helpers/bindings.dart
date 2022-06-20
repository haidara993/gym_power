import 'package:get/get.dart';
import 'package:gym_power/controllers/auth_viewmodel.dart';
import 'package:gym_power/controllers/control_viewmodel.dart';
import 'package:gym_power/controllers/home_viewmodel.dart';
import 'package:gym_power/controllers/network_viewmodel.dart';
import 'package:gym_power/controllers/workout_viewmodel.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => WorkoutViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => NetworkViewModel());
  }
}
