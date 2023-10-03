import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:iml_test_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:iml_test_app/features/authentication/presentation/pages/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iml_test_app/features/dashboard/domain/entitities/file_adapter.dart';
import 'package:iml_test_app/features/dashboard/domain/entitities/user_profile_entity.dart';
import 'package:iml_test_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:iml_test_app/src/ui/constants/hive_keys.dart';
import 'package:iml_test_app/src/ui/constants/routes/route.dart';
import 'package:iml_test_app/src/ui/utils/injection_container.dart' as di;

import '../features/authentication/domain/entities/user_entity.dart';
import '../features/navigation/cubit/navigation_cubit.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();
  // Register the UserEntity adapter
  Hive.registerAdapter(UserEntityAdapter());
  Hive.registerAdapter(UserProfileEntityAdapter());
  Hive.registerAdapter(FileAdapter());

  await di.init();
  await Hive.openBox(HiveKeys.loginBox);
  await Hive.openBox(HiveKeys.userProfileBox);
  await Hive.openBox(HiveKeys.preferenceBox);

  runApp(EasyLocalization(
    path: 'lib/core/assets/strings',
    supportedLocales: const <Locale>[
      Locale('en', 'US'),
    ],
    child: const MyApp(),
  ));
}

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
            create: (context) =>
                di.serviceLocater<AuthenticationCubit>()),
                // ..fetchCredentials()),
        BlocProvider<DashboardCubit>(
            create: (context) =>
                di.serviceLocater<DashboardCubit>()),
                // ..fetchCurrentUser()),
        BlocProvider<NavigationCubit>(
            create: (context) => di.serviceLocater<NavigationCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          EasyLocalization.of(context)!.delegate,
        ],
        locale: EasyLocalization.of(context)!.locale,
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        home: BlocProvider(
          create: (context) => NavigationCubit(),
          child: const SplashScreen(),
        ),
        routes: approutes,
        // routerConfig: AppRoutesConfig().router,
      ),
    );
  }
}
