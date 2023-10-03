import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iml_test_app/features/authentication/domain/entities/user_entity.dart';

abstract class AuthRepository {
  ///google sign in instance
  final GoogleSignIn googleSignIn;
  ///auth instance
  final FirebaseAuth auth;

  AuthRepository({required this.googleSignIn, required this.auth, });
  Future<void> signIn(UserEntity userData);

  Future<void> isSignIn();

  Future<void> signOut();

  Future<UserEntity?> fetchCredentials();

  Future<UserEntity?> googleSignedIn();

//   Future<void> updateLoginData(String email, String password, bool isRememberMe);
 }
