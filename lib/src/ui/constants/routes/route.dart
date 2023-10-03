
import 'package:flutter/material.dart';
import 'package:iml_test_app/features/authentication/presentation/pages/login_screen.dart';
import 'package:iml_test_app/features/authentication/presentation/pages/splash_screen.dart';
import 'package:iml_test_app/features/dashboard/presentation/pages/home_screen.dart';
import 'package:iml_test_app/features/dashboard/presentation/pages/profile_screen.dart';

import '../../../../features/dashboard/presentation/pages/edit_profile_screen.dart';

final Map<String,Widget Function(BuildContext context)> approutes= <String, WidgetBuilder> {
  SplashScreen.route : (context) =>const SplashScreen(),
  LoginScreen.route: (context) =>const LoginScreen(),
  HomeScreen.route: (context) => const HomeScreen(),
  EditProfileScreen.route :(context) => const EditProfileScreen(),
   ProfileScreen.route : (context) => const ProfileScreen(),
};