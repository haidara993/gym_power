import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_power/core/const/global_const.dart';
import 'package:gym_power/core/data/workout_data.dart';
import 'package:gym_power/core/services/user_storage_service.dart';

class DataService {
  static Future<List<WorkoutData>> getWorkoutsForUser() async {
    final currUserEmail = FirebaseAuth.instance.currentUser?.email;

    // await UserStorageService.deleteSecureData('${currUserEmail}Workouts');

    final workoutsStr =
        await UserStorageService.readSecureData('${currUserEmail}Workouts');
    if (workoutsStr == null) return [];
    final decoded = (json.decode(workoutsStr) as List?) ?? [];
    final workouts = decoded.map((e) {
      final decodedE = json.decode(e) as Map<String, dynamic>?;
      return WorkoutData.fromJson(decodedE!);
    }).toList();
    GlobalConstants.workouts = workouts;
    return workouts;
  }

  static Future<void> saveWorkout(WorkoutData workout) async {
    final allWorkouts = await getWorkoutsForUser();
    final index = allWorkouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      allWorkouts[index] = workout;
    } else {
      allWorkouts.add(workout);
    }
    GlobalConstants.workouts = allWorkouts;
    final workoutsStr = allWorkouts.map((e) => e.toJsonString()).toList();
    final encoded = json.encode(workoutsStr);
    final currUserEmail = GlobalConstants.currentUser.mail;
    await UserStorageService.writeSecureData(
      '${currUserEmail}Workouts',
      encoded,
    );
  }
}
