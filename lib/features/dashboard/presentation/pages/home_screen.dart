import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iml_test_app/features/authentication/presentation/pages/login_screen.dart';
import 'package:iml_test_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:iml_test_app/features/dashboard/presentation/pages/profile_screen.dart';
import 'package:iml_test_app/features/dashboard/presentation/widgets/custom_buttons_heading.dart';
import 'package:iml_test_app/src/ui/constants/assets.dart';
import 'package:iml_test_app/src/ui/constants/colors.dart';
import 'package:iml_test_app/src/ui/constants/dimensions.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../src/ui/utils/log_extension.dart';
import '../../../authentication/presentation/widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  ///route
  static const String route = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final log = logger;

  @override
  void initState() {
    BlocProvider.of<DashboardCubit>(context).fetchCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        log.i(state);
        if (state is DashboardLoaded) {
          // log.i(state.currentUser!.skills);
        }
      },
      builder: (context, state) {
        // log.i(state);
        if (state is DashboardLogout) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context).popAndPushNamed(LoginScreen.route);
          });
        }

        if (state is DashboardLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<DashboardCubit>(context).logoutUser();
                    },
                    icon: Icon(
                      Icons.logout_sharp,
                      color: AppColors.darkBlue,
                    ))
              ],
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.dp_15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            (state.currentUser != null &&
                                    state.currentUser!.userProfilePic != null)
                                ? Container(
                                    height: Dimensions.dp_100,
                                    width: Dimensions.dp_100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppColors.darkBlue),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: FileImage(
                                            state.currentUser!.userProfilePic!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: Dimensions.dp_100,
                                    width: Dimensions.dp_100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: AppColors.darkBlue),
                                      shape: BoxShape.circle,
                                      image: const DecorationImage(
                                        image: AssetImage(AppAssets.avatarImg),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              width: Dimensions.dp_30,
                            ),
                            Expanded(
                                child: (state.currentUser != null &&
                                        state.currentUser!.userName != null)
                                    ? Text(
                                        'Welcome ${state.currentUser!.userName}',
                                        style: TextStyle(
                                            color: AppColors.darkBlue,
                                            fontSize: Dimensions.dp_20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        'Welcome User',
                                        style: TextStyle(
                                            color: AppColors.darkBlue,
                                            fontSize: Dimensions.dp_20,
                                            fontWeight: FontWeight.bold),
                                      ))
                          ],
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: CustomButtonHeading(
                              headingText: LocaleKeys.name.tr())),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.dp_10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: (state.currentUser != null &&
                                    state.currentUser!.userName != null)
                                ? Text(
                                    state.currentUser!.userName!,
                                    style: TextStyle(
                                        color: AppColors.darkBlue,
                                        fontSize: Dimensions.dp_18,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(
                                    LocaleKeys.no_data_provided.tr(),
                                    style: TextStyle(
                                        color: AppColors.darkBlue,
                                        fontSize: Dimensions.dp_18,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: CustomButtonHeading(
                              headingText: LocaleKeys.introduction.tr())),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.dp_10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: (state.currentUser != null &&
                                  state.currentUser!.userIntro != null)
                              ? Text(
                                  state.currentUser!.userIntro!,
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: Dimensions.dp_18,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  LocaleKeys.no_data_provided.tr(),
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: Dimensions.dp_18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: CustomButtonHeading(
                              headingText: LocaleKeys.email.tr())),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.dp_10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: (state.currentUser != null)
                              ? Text(state.currentUser!.userEmail,
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: Dimensions.dp_18,
                                      fontWeight: FontWeight.bold))
                              : Text(
                                  LocaleKeys.no_data_provided,
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: Dimensions.dp_18,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: CustomButtonHeading(
                              headingText: LocaleKeys.skills.tr())),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.dp_10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: (state.currentUser != null &&
                                  state.currentUser!.skills != null)
                              ? Wrap(
                                  spacing: 2.0,
                                  runSpacing: 1.0,
                                  children:
                                      itemsChips(state.currentUser!.skills!))
                              : Text(
                                  LocaleKeys.no_data_provided.tr(),
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: Dimensions.dp_18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: CustomButtonHeading(
                              headingText: LocaleKeys.experience.tr())),
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.dp_10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: (state.currentUser != null &&
                                  state.currentUser!.userExperience != null)
                              ? Text(
                                  '${state.currentUser!.userExperience!} years',
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: Dimensions.dp_18,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  LocaleKeys.no_data_provided.tr(),
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontSize: Dimensions.dp_18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      ButtonWidget(
                        onPressed: () {
                          // GoRouter.of(context).pushReplacementNamed(
                          //   AppRouteConstants.editProfile,
                          // );

                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ProfileScreen.route, (route) => false);
                        },
                        btnWidth: MediaQuery.of(context).size.width / 2,
                        text: LocaleKeys.edit_profile.tr(),
                        hasLeading: false,
                        leadingAsset: null,
                        backgroundColor: AppColors.buttonTextColor,
                        textColor: Colors.white,
                      ),
                    ]),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  List<Widget> itemsChips(List<String?> chipsTitle) {
    List<Widget> chips = [];
    bool isSelected = false;
    for (int i = 0; i < chipsTitle.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 0, right: 5),
        child: InputChip(
          label: Text(chipsTitle[i]!.toUpperCase()),
          labelStyle: TextStyle(color: AppColors.darkBlue),
          backgroundColor: AppColors.lightBlue,
          selected: isSelected,
          onSelected: (bool value) {
            setState(() {
              isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
