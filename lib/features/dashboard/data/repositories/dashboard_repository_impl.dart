
import 'package:hive/hive.dart';
import 'package:iml_test_app/features/authentication/domain/entities/user_entity.dart';
import 'package:iml_test_app/features/dashboard/domain/entitities/user_profile_entity.dart';
import 'package:iml_test_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:iml_test_app/src/ui/constants/hive_keys.dart';
import 'package:iml_test_app/src/ui/utils/log_extension.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  final log = logger;

  DashboardRepositoryImpl({required super.googleSignIn, required super.auth});
  @override
  Future<UserProfileEntity?> getCurrentUser() async {
    final UserEntity? userEntity =
        await Hive.box(HiveKeys.loginBox).get(HiveKeys.currentUser);

    UserProfileEntity? userProfile =
        await Hive.box(HiveKeys.userProfileBox).get(HiveKeys.userProfileData);
    if (userProfile != null && userProfile.userEmail == userEntity!.uemail) {
      return userProfile;
    } else {
      final userProfileData = UserProfileEntity(
          userEmail: userEntity!.uemail!,
          userName: null,
          userIntro: null,
          skills: null,
          userExperience: null,
          userProfilePic: null);
      await Hive.box(HiveKeys.userProfileBox)
          .put(HiveKeys.userProfileData, userProfile);
      //   Hive.box(HiveKeys.userProfileBox).clear();
      return userProfileData;
    }
  }

  @override
  Future<void> saveUserProfile(UserProfileEntity userProfileEntity) async {
    log.i(userProfileEntity.skills);
    await Hive.box(HiveKeys.userProfileBox)
        .put(HiveKeys.userProfileData, userProfileEntity);
  }

  @override
  Future<void> updateUserProfile(UserProfileEntity userProfileEntity) async {
    final currentUserEmail =
        await Hive.box(HiveKeys.loginBox).get(HiveKeys.userEmail);

    if (currentUserEmail == userProfileEntity.userEmail) {
      // Hive.box(HiveKeys.userProfileBox).putAt(index, value)
    }
  }

  @override
  Future<List<String>> addSkills(String skills) async {
    UserProfileEntity currentUserData =
        await Hive.box(HiveKeys.userProfileBox).get(HiveKeys.userProfileData);

    List<String> currentSkills = [];

    if (skills.isNotEmpty) {
      currentSkills.add(skills);
    }

    if (currentUserData.skills != null) {
      final List<String> allSkills = <String>[
        ...currentUserData.skills!,
        ...currentSkills,
      ];
      return allSkills;
    } else {
      final List<String> allSkills = <String>[
        ...currentSkills,
      ];
      return allSkills;
    }
  }

  @override
  Future<void> googleLogout() async {
    await auth.signOut();
  }

  @override
  Future<bool> getIfGoogleSignIn() async {
    final bool isGoogleLogin =
        await Hive.box(HiveKeys.loginBox).get(HiveKeys.isgoogleSignin);
    return isGoogleLogin;
  }

  @override
  Future<void> logout() async {
    final loginBox = Hive.box(HiveKeys.loginBox);

    await loginBox.clear();

    //await userProfileBox.clear();
  }
}
