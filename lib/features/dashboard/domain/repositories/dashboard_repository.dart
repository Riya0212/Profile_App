import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iml_test_app/features/dashboard/domain/entitities/user_profile_entity.dart';

abstract class DashboardRepository {
  ///google sign in instance
  final GoogleSignIn googleSignIn;

  ///auth instance
  final FirebaseAuth auth;

  DashboardRepository({required this.googleSignIn, required this.auth});

  Future<UserProfileEntity?> getCurrentUser();

  Future<void> saveUserProfile(UserProfileEntity userProfileEntity);

  Future<void> updateUserProfile(UserProfileEntity userProfileEntity);

  Future<List<String>> addSkills(String skills);

  Future<void> googleLogout();

  Future<bool> getIfGoogleSignIn();

  Future<void> logout();
}
