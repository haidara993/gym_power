import 'package:get/get.dart';
import 'package:gym_power/core/const/data_constants.dart';
import 'package:gym_power/core/const/global_const.dart';
import 'package:gym_power/core/data/workout_data.dart';
import 'package:gym_power/core/services/data_service.dart';

class WorkoutViewModel extends GetxController {
  List<WorkoutData> _workouts = DataConstants.workouts;
  List<WorkoutData> get workouts => _workouts;

  late WorkoutData _workout;
  WorkoutData get workout => _workout;

  int? index;
  bool? isReplace;

  int _time = 0;
  int get time => _time;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    GlobalConstants.workouts = await DataService.getWorkoutsForUser();

    for (int i = 0; i < _workouts.length; i++) {
      final workoutsUserIndex =
          GlobalConstants.workouts.indexWhere((w) => w.id == _workouts[i].id);
      if (workoutsUserIndex != -1) {
        _workouts[i] = GlobalConstants.workouts[workoutsUserIndex];
        update();
      }
    }
  }
}
