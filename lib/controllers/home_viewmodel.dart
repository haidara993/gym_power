import 'package:get/get.dart';
import 'package:gym_power/controllers/auth_viewmodel.dart';
import 'package:gym_power/core/const/data_constants.dart';
import 'package:gym_power/core/data/exercise_data.dart';
import 'package:gym_power/core/data/workout_data.dart';

class HomeViewModel extends GetxController {
  List<WorkoutData> _workouts = <WorkoutData>[];
  List<WorkoutData> get workouts => _workouts;

  List<ExerciseData> _exercises = <ExerciseData>[];
  List<ExerciseData> get exercises => _exercises;

  int _timeSent = 0;
  int get timeSent => _timeSent;

  String? _photoURL;
  String? get photoURL => _photoURL;

  String? _displayName;
  String? get displayName => _displayName;

  int _percent = 0;
  int get percent => _percent;

  int _finishedWorkouts = 0;
  int get finishedWorkouts => _finishedWorkouts;

  int _inProgressWorkouts = 0;
  int get inProgressWorkouts => _inProgressWorkouts;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _displayName = Get.find<AuthViewModel>().currentuser.value?.displayName;
    _photoURL = Get.find<AuthViewModel>().currentuser.value?.photoURL;
    update();
  }

  getProgressPercentage() {
    final completed = workouts
        .where((w) =>
            (w.currentProgress ?? 0) > 0 && w.currentProgress == w.progress)
        .toList();
    final percent01 =
        completed.length.toDouble() / DataConstants.workouts.length.toDouble();
    _percent = (percent01 * 100).toInt();
    update();
  }

  getFinishedWorkouts() {
    final completedWorkouts =
        workouts.where((w) => w.currentProgress == w.progress).toList();
    _finishedWorkouts = completedWorkouts.length;
    update();
  }

  getInProgressWorkouts() {
    final completedWorkouts = workouts.where(
        (w) => (w.currentProgress ?? 0) > 0 && w.currentProgress != w.progress);
    _inProgressWorkouts = completedWorkouts.length;
  }

  getTimeSent() {
    for (final WorkoutData workout in workouts) {
      exercises.addAll(workout.exerciseDataList!);
    }
    final exercise = exercises.where((e) => e.progress == 1).toList();
    exercise.forEach((e) {
      _timeSent += e.minutes!;
    });
    update();
  }
}
