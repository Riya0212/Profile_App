import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:iml_test_app/features/authentication/domain/entities/user_entity.dart';
import 'package:iml_test_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:iml_test_app/features/authentication/presentation/widgets/button_widget.dart';
import 'package:iml_test_app/features/authentication/presentation/widgets/checkbox_widget.dart';
import 'package:iml_test_app/features/dashboard/presentation/pages/home_screen.dart';
import 'package:iml_test_app/src/ui/constants/assets.dart';
import 'package:iml_test_app/src/ui/constants/colors.dart';
import 'package:iml_test_app/src/ui/constants/dimensions.dart';
import 'package:iml_test_app/src/ui/constants/widgets/custom_textformfield_widget.dart';
import 'package:iml_test_app/src/ui/utils/validation_utils.dart';
import 'package:iml_test_app/generated/locale_keys.g.dart';

import '../../../../src/ui/utils/log_extension.dart';

///login screen page
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  ///route
  static const String route = 'LoginScreen';
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController unameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool rememberMe = false;

  late Box loginBox;

  final log = logger;

  @override
  void initState() {
    super.initState();
    // Initialize text controller values to null
    unameController.text = '';
    passController.text = '';
      BlocProvider.of<AuthenticationCubit>(context).fetchCredentials();
  }

  void _onCredentialsReceived(UserEntity credentials) {
    final storedEmail = credentials.uemail;
    final storedPassword = credentials.upassword;

    if (storedEmail != null && storedPassword != null) {
      unameController.text = storedEmail;
      passController.text = storedPassword;
      rememberMe = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    void performSignIn() {
      final userData = UserEntity(
          uemail: unameController.text,
          upassword: passController.text,
          isRememberMe: rememberMe);
      BlocProvider.of<AuthenticationCubit>(context)
          .submitSignIn(userData: userData);
    }

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        log.i(state);
        if (state is AuthenticationInitial && state.userLoggedData != null) {
          final UserEntity userData = state.userLoggedData!;
          _onCredentialsReceived(userData);
        }
        if (state is AuthenticationSuccess) {
          Future.delayed(Duration.zero, () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: AppColors.colorList,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.dp_10),
                child: Column(children: [
                  const SizedBox(
                    height: Dimensions.dp_100,
                  ),
                  Center(
                    child: Image.asset(
                      AppAssets.splashScreenLogo,
                      height: Dimensions.dp_100,
                      width: Dimensions.dp_150,
                    ),
                  ),
                  Text(
                    LocaleKeys.welcome_text.tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.dp_25),
                  ),
                  const SizedBox(
                    height: Dimensions.dp_30,
                  ),
                  Text(
                    LocaleKeys.login.tr(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.dp_25),
                  ),
                  const SizedBox(
                    height: Dimensions.dp_30,
                  ),
                  CustomTextFormFieldWidget(
                      labelText: LocaleKeys.username.tr(),
                      leadingIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      hintText: LocaleKeys.username_hint.tr(),
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      textController: unameController,
                      ifPassword: false,
                      onChanged: (val) {
                        unameController.text = val;
                      },
                      validator: ValidationUtils.emailValidator),
                  const SizedBox(
                    height: Dimensions.dp_10,
                  ),
                  CustomTextFormFieldWidget(
                      labelText: LocaleKeys.password.tr(),
                      leadingIcon: const Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      hintText: LocaleKeys.password_hint.tr(),
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      textController: passController,
                      ifPassword: true,
                      onChanged: (val) {
                        passController.text = val;
                      },
                      validator: ValidationUtils.passwordValidator),
                  const SizedBox(
                    height: Dimensions.dp_5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.dp_5),
                    child: Row(
                      children: [
                        CheckboxWidget(
                          activeColor: Colors.white,
                          onChanged: () {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          },
                          selected: rememberMe,
                        ),
                        const SizedBox(
                          width: Dimensions.dp_10,
                        ),
                        Text(
                          LocaleKeys.remember_me.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: Dimensions.dp_16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.dp_15,
                  ),
                  Stack(
                    children: [
                      ButtonWidget(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            debugPrint('Success');
                            performSignIn();
                          } else {
                            log.i('no');
                          }
                        },
                        text: LocaleKeys.login.tr(),
                        hasLeading: false,
                        leadingAsset: null,
                        backgroundColor: Colors.white,
                        textColor: AppColors.buttonTextColor,
                      ),
                      if (state is AuthenticationLoading)
                        const Positioned.fill(
                          child: Center(
                            child:
                                CircularProgressIndicator(), // Replace with your desired loading indicator
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.dp_10,
                  ),
                  RichText(
                    text:  TextSpan(
                      style: const TextStyle(
                        fontSize: Dimensions.dp_15,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(text:  LocaleKeys.new_account.tr()),
                        TextSpan(
                            text: LocaleKeys.signup.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.dp_15,
                  ),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Expanded(
                            child: Divider(
                          color: Colors.grey,
                        )),
                        const SizedBox(
                          width: Dimensions.dp_5,
                        ),
                        Text(
                          LocaleKeys.or.tr(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: Dimensions.dp_15),
                        ),
                        const SizedBox(
                          width: Dimensions.dp_5,
                        ),
                        const Expanded(child: Divider(color: Colors.grey)),
                      ]),
                  const SizedBox(
                    height: Dimensions.dp_10,
                  ),
                  ButtonWidget(
                    btnWidth: MediaQuery.of(context).size.width / 2,
                    onPressed: () {
                      BlocProvider.of<AuthenticationCubit>(context)
                          .doGoogleSignIn();
                    },
                    text: LocaleKeys.login.tr(),
                    hasLeading: true,
                    leadingAsset: null,
                    backgroundColor: Colors.white,
                    textColor: AppColors.buttonTextColor,
                  ),
                ]),
              ),
            ),
          ),
        ));
      },
    );
  }

  @override
  void dispose() {
    unameController.dispose();
    passController.dispose();
    super.dispose();
  }
  // void performSignIN(BuildContext context) {
  //   // if (rememberMe) {
  //   //   loginBox.put('email', unameController.text);
  //   //   loginBox.put('password', passController.text);
  //   // }
  // }

  // void getData() async {
  //   if (loginBox.get('email') != null) {
  //     unameController.text = loginBox.get('email');
  //     rememberMe = true;
  //     setState(() {

  //     });
  //   }
  //   if (loginBox.get('password') != null) {
  //     passController.text = loginBox.get('password');
  //      rememberMe = true;
  //     setState(() {

  //     });
  //   }
}
