import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_power/core/extensions/exceptions.dart';

class UserService {
  static FirebaseAuth firebase = FirebaseAuth.instance;

  static Future<bool> editPhoto(String photoUrl) async {
    try {
      await firebase.currentUser?.updatePhotoURL(photoUrl);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> changeUserData(
      {required String displayName, required String email}) async {
    try {
      await firebase.currentUser?.updateDisplayName(displayName);
      await firebase.currentUser?.updateEmail(email);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> changePassword({required String newPassword}) async {
    try {
      await firebase.currentUser?.updatePassword(newPassword);
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> signOut() async {
    await firebase.signOut();
  }
}
