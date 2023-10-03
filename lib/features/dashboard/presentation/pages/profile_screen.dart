import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iml_test_app/features/authentication/presentation/widgets/button_widget.dart';
import 'package:iml_test_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:iml_test_app/src/ui/constants/hive_keys.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../src/ui/constants/assets.dart';
import '../../../../src/ui/constants/colors.dart';
import '../../../../src/ui/constants/dimensions.dart';
import '../../../../src/ui/utils/log_extension.dart';
import '../../../../src/ui/utils/validation_utils.dart';
import '../../domain/entitities/user_profile_entity.dart';
import '../widgets/textform_field_widget.dart';
import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  ///route
  static const String route = 'ProfileScreen';
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController introductionController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();
  List<String>? currentSkills = [];
  File? profileImage;

  final log = logger;

  @override
  void initState() {
    BlocProvider.of<DashboardCubit>(context).fetchCurrentUser();
    super.initState();
  }

  void saveProfileData() async {
    final username = usernameController.text;
    final email = emailController.text;
    final intro = introductionController.text;
    final skills = currentSkills;
    final experience = experienceController.text;
    final profile = profileImage;

    final userProfile = UserProfileEntity(
        userEmail: email,
        userName: username,
        userIntro: intro,
        skills: skills,
        userExperience: experience,
        userProfilePic: profile);

    BlocProvider.of<DashboardCubit>(context).saveUser(userProfile);

    final UserProfileEntity user =
        await Hive.box(HiveKeys.userProfileBox).get(HiveKeys.userProfileData);
    log.i(user.skills);

    Navigator.of(context).pushReplacementNamed(HomeScreen.route);
  }

  void addNewSkill(String skill) {
    currentSkills!.add(skill);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        log.i(state);
        if (state is DashboardLoaded) {
          emailController.text = state.currentUser!.userEmail;

          usernameController.text = state.currentUser!.userName ?? '';
          introductionController.text = state.currentUser!.userIntro ?? '';
          experienceController.text = state.currentUser!.userExperience ?? '';
          if (state.currentUser!.userProfilePic != null) {
            profileImage = state.currentUser!.userProfilePic;
          }
          log.i(state.currentUser!.skills);
          if (state.currentUser!.skills != null) {
            currentSkills = List.from(state.currentUser!.skills as Iterable);
          }
        }
      },
      builder: (context, state) {
        // if (state is DashboardInitial) {
        //   BlocProvider.of<DashboardCubit>(context).fetchCurrentUser();
        // }
        if (state is DashboardLoaded) {}
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.darkBlue,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.route, (route) => false);
              },
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: Form(
            key: _formKey2,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.dp_10),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              elevation: 0,
                              backgroundColor: AppColors.buttonTextColor,
                              builder: (context) => SizedBox(
                                  height: Dimensions.dp_80,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(Dimensions.dp_5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    getImage(
                                                        ImageSource.camera);
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: const Icon(
                                                    Icons.camera,
                                                    color: Colors.white,
                                                  )),
                                              Text(
                                                LocaleKeys.camera.tr(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions.dp_16),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    getImage(
                                                        ImageSource.gallery);
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: const Icon(
                                                    Icons.photo_library,
                                                    color: Colors.white,
                                                  )),
                                              Text(
                                                LocaleKeys.gallery.tr(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions.dp_16),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      profileImage = null;
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  )),
                                              Text(
                                                LocaleKeys.remove.tr(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: Dimensions.dp_16),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )));
                        },
                        child: (profileImage != null)
                            ? Container(
                                height: Dimensions.dp_100,
                                width: Dimensions.dp_100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: AppColors.darkBlue),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      // image: AssetImage(AppAssets.avatarImg),
                                      image: FileImage(profileImage as File),
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high),
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
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.dp_10,
                    ),
                    Center(
                      child: Text(
                        LocaleKeys.edit_profile.tr(),
                        style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: Dimensions.dp_15),
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.dp_10,
                    ),
                    TextFormFieldWidget(
                      labelText: LocaleKeys.user_name.tr(),
                      hintText: LocaleKeys.user_name_hint.tr(),
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      textController: usernameController,
                      validator: ValidationUtils.usernameValidator,
                      hasMaxLines: false,
                      isEnabled: true,
                      initialValue: null,
                    ),
                    const SizedBox(
                      height: Dimensions.dp_10,
                    ),
                    TextFormFieldWidget(
                      labelText: LocaleKeys.email.tr(),
                      hintText: LocaleKeys.user_name_hint.tr(),
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textController: emailController,
                      isEnabled: false,
                      hasMaxLines: false,
                      validator: null,
                      initialValue: '',
                    ),
                    const SizedBox(
                      height: Dimensions.dp_10,
                    ),
                    TextFormFieldWidget(
                      labelText: LocaleKeys.introduction.tr(),
                      hintText: LocaleKeys.intro_hint.tr(),
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      isEnabled: true,
                      textController: introductionController,
                      hasMaxLines: true,
                      validator: ValidationUtils.introValidator,
                      initialValue: '',
                    ),
                    const SizedBox(
                      height: Dimensions.dp_10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormFieldWidget(
                            labelText: LocaleKeys.skills.tr(),
                            hintText: LocaleKeys.skills_hint.tr(),
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            textController: skillsController,
                            isEnabled: true,
                            hasMaxLines: false,
                            validator: null,
                            initialValue: '',
                          ),
                        ),
                        Expanded(
                          child: ButtonWidget(
                              onPressed: () {
                                addNewSkill(skillsController.text);
                              },
                              text: LocaleKeys.add_skills.tr(),
                              hasLeading: false,
                              btnWidth: MediaQuery.of(context).size.width / 3,
                              leadingAsset: null,
                              backgroundColor: AppColors.darkBlue,
                              textColor: Colors.white),
                        )
                      ],
                    ),
                    Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 4.0,
                        runSpacing: 2.0,
                        children: itemsChips(currentSkills!)),
                    const SizedBox(
                      height: Dimensions.dp_10,
                    ),
                    TextFormFieldWidget(
                      labelText: LocaleKeys.experience.tr(),
                      hintText: LocaleKeys.experience_hint.tr(),
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      isEnabled: true,
                      textController: experienceController,
                      hasMaxLines: false,
                      validator: ValidationUtils.experienceValidator,
                      initialValue: '',
                    ),
                    const SizedBox(
                      height: Dimensions.dp_15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonWidget(
                              onPressed: () {
                                if (_formKey2.currentState!.validate()) {
                                  saveProfileData();
                                }
                              },
                              text: LocaleKeys.save.tr(),
                              hasLeading: false,
                              btnWidth: MediaQuery.of(context).size.width / 2,
                              leadingAsset: null,
                              backgroundColor: AppColors.darkBlue,
                              textColor: Colors.white),
                        ),
                        Expanded(
                          child: ButtonWidget(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    content: Text(
                                      LocaleKeys.alert_msg.tr(),
                                      style: const TextStyle(
                                          fontSize: Dimensions.dp_20),
                                    ),
                                    actions: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        HomeScreen.route,
                                                        (route) => false);
                                              },
                                              child: Text(
                                                LocaleKeys.yes.tr(),
                                                style: TextStyle(
                                                    color: AppColors.darkBlue,
                                                    fontSize: Dimensions.dp_18),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text(
                                                LocaleKeys.no.tr(),
                                                style: TextStyle(
                                                    color: AppColors.darkBlue,
                                                    fontSize: Dimensions.dp_18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                                // if (_formKey2.currentState!.validate()) {
                                //   saveProfileData();
                                // }
                              },
                              text: LocaleKeys.cancel.tr(),
                              hasLeading: false,
                              btnWidth: MediaQuery.of(context).size.width / 2,
                              leadingAsset: null,
                              backgroundColor: Colors.red,
                              textColor: Colors.white),
                        )
                      ],
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

  void getImage(
    ImageSource img,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          profileImage = File(pickedFile!.path);
          // profileImage = Image.file(File(pickedFile!.path));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
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
          labelStyle: const TextStyle(color: Colors.white),
          backgroundColor: AppColors.darkBlue,
          selected: isSelected,
          onDeleted: () {
            setState(() {
              chipsTitle.removeAt(i);
            });
          },
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
