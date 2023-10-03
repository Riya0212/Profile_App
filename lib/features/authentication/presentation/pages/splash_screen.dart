import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iml_test_app/features/authentication/presentation/pages/login_screen.dart';
import 'package:iml_test_app/features/navigation/cubit/navigation_cubit.dart';
import 'package:iml_test_app/src/ui/constants/assets.dart';
import 'package:iml_test_app/src/ui/constants/colors.dart';
import 'package:iml_test_app/src/ui/constants/dimensions.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../src/ui/utils/log_extension.dart';

///splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  ///route
  static const String route = 'SplashScreen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController scaleanimator =
      AnimationController(vsync: this, duration: const Duration(seconds: 2));

  @override
  void initState() {
    scaleanimator.forward().whenComplete(() =>
        BlocProvider.of<NavigationCubit>(context).navigateToAuthentication());
    // .whenComplete(() => Future.delayed(const Duration(seconds: 2), () {
    //       // Navigator.of(context).push(
    //       //     MaterialPageRoute(builder: (context) => const LoginScreen()));
    //       BlocProvider.of<NavigationCubit>(context)
    //           .navigateToAuthentication();
    //     }));

    super.initState();
  }

  @override
  void dispose() {
    scaleanimator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final log = logger;
    late final Animation<double> scaleTransition =
        CurvedAnimation(parent: scaleanimator, curve: Curves.easeInCubic);

    return BlocConsumer<NavigationCubit, NavigationState>(
      listener: (context, state) {
        log.i(state);
      },
      builder: (context, state) {
        if (state is NavigateToAuthenticationState) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.route, (route) => false);
          });
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: AppColors.colorList,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // stops: const [0.1,0.3, 0.5, 0.6, 0.9]
            )),
            child: ScaleTransition(
              scale: scaleTransition,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.splashScreenLogo,
                      height: Dimensions.dp_150,
                      width: Dimensions.dp_150,
                    ),
                    const SizedBox(
                      height: Dimensions.dp_10,
                    ),
                    Text(
                      LocaleKeys.profile_app.tr(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.dp_20),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
