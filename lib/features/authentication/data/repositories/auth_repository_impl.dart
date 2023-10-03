import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:iml_test_app/features/authentication/domain/entities/user_entity.dart';
import 'package:iml_test_app/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../src/ui/constants/hive_keys.dart';
import '../../../dashboard/domain/entitities/user_profile_entity.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required super.googleSignIn, required super.auth});

  @override
  Future<void> isSignIn() {
    // TODO: implement isSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    final loginBox = Hive.box(HiveKeys.loginBox);
    final preferenceBox = Hive.box(HiveKeys.preferenceBox);

    loginBox.clear();
    preferenceBox.clear();
  }

  @override
  Future<void> signIn(UserEntity userData) async {
    final String userEmail = userData.uemail!;
    final String userPassword = userData.upassword!;
    final bool isRememberMe = userData.isRememberMe;

    if (isRememberMe) {
      final user = UserEntity(
          uemail: userEmail,
          upassword: userPassword,
          isRememberMe: isRememberMe);
      //await Hive.box(HiveKeys.loginBox).put(HiveKeys.user, user);
      await Hive.box(HiveKeys.preferenceBox).put(HiveKeys.isRememberMe, user);
    } else {
      await Hive.box(HiveKeys.preferenceBox).delete(HiveKeys.isRememberMe);
    }

    final currentUser = UserEntity(
        uemail: userEmail, upassword: userPassword, isRememberMe: isRememberMe);
    await Hive.box(HiveKeys.loginBox).put(HiveKeys.currentUser, currentUser);

    UserProfileEntity? userProfile =
        await Hive.box(HiveKeys.userProfileBox).get(HiveKeys.userProfileData);
    

    if (userProfile == null) {
      final userProfile = UserProfileEntity(
          userEmail: userEmail,
          userName: null,
          userIntro: null,
          skills: null,
          userExperience: null,
          userProfilePic: null);
      await Hive.box(HiveKeys.userProfileBox)
          .put(HiveKeys.userProfileData, userProfile);
      await Hive.box(HiveKeys.loginBox).put(HiveKeys.isgoogleSignin, false);
    }
  }

  @override
  Future<UserEntity?> fetchCredentials() {
    final UserEntity? user =
        Hive.box(HiveKeys.preferenceBox).get(HiveKeys.isRememberMe);
    // print(user!.uemail ?? '');
    return Future<UserEntity?>.value(user);
  }

  @override
  Future<UserEntity?> googleSignedIn() async {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await account!.authentication;

    final OAuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    final User? userInformation =
        (await auth.signInWithCredential(authCredential)).user;

    if (userInformation != null) {
      final currentUser = UserEntity(
          uemail: userInformation.email, upassword: null, isRememberMe: false);
      await Hive.box(HiveKeys.loginBox).put(HiveKeys.currentUser, currentUser);

      UserProfileEntity? userProfile =
          await Hive.box(HiveKeys.userProfileBox).get(HiveKeys.userProfileData);

      if (userProfile == null) {
        final userProfile = UserProfileEntity(
            userEmail: userInformation.email!,
            userName: null,
            userIntro: null,
            skills: null,
            userExperience: null,
            userProfilePic: null);
        await Hive.box(HiveKeys.userProfileBox)
            .put(HiveKeys.userProfileData, userProfile);

        await Hive.box(HiveKeys.loginBox).put(HiveKeys.isgoogleSignin, true);
      }
      return currentUser;
    } else {
      return null;
    }
  }

  
}
