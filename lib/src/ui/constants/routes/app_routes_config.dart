import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iml_test_app/features/dashboard/presentation/pages/profile_screen.dart';

import '../../../../features/authentication/presentation/pages/login_screen.dart';
import '../../../../features/authentication/presentation/pages/splash_screen.dart';
import '../../../../features/dashboard/presentation/pages/home_screen.dart';
import 'app_route_constants.dart';

///go router class configuration
class AppRoutesConfig {
  ///router object for routes
  GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      name: AppRouteConstants.splash,
      path: '/',
      pageBuilder: (BuildContext context, _) =>
          const MaterialPage<dynamic>(child: SplashScreen()),
    ),
    // GoRoute(
    //     path: '/dashboard',
    //     name: AppRouteConstants.dashboard,
    //     builder: (BuildContext context, GoRouterState state) => HomeScreen()),
    GoRoute(
        path: '/login',
        name: AppRouteConstants.login,
        pageBuilder: (BuildContext context, _) =>
            const MaterialPage<dynamic>(child: LoginScreen())),
    GoRoute(
        path: '/dashboard',
        name: AppRouteConstants.dashboard,
        builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
        routes: <RouteBase>[
          GoRoute(
              path: '/editProfile',
              name: AppRouteConstants.editProfile,
              builder: (BuildContext context, _) => const ProfileScreen(

                  //  userProfileEntity: _.pathParameters['currentUserEmail']!,
                  ))
        ]),
    GoRoute(
        path: '/editProfile',
        name: AppRouteConstants.editProfile,
        builder: (BuildContext context, _) => const ProfileScreen())
  ]);
}
