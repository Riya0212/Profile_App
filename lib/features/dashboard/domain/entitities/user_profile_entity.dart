import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
part 'user_profile_entity.g.dart';
@HiveType(typeId: 1)
class UserProfileEntity extends HiveObject {
  @HiveField(0)
  final String userEmail;

  @HiveField(1)
  final String? userName;

  @HiveField(2)
  final String? userIntro;

  @HiveField(3)
  final List<String>? skills;

  @HiveField(4)
  final String? userExperience;

  @HiveField(5)
  final File? userProfilePic;

  UserProfileEntity(
      {required this.userEmail,
      required this.userName,
      required this.userIntro,
      required this.skills,
      required this.userExperience,
      required this.userProfilePic, });
}
