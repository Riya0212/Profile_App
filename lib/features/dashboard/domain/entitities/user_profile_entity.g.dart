// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileEntityAdapter extends TypeAdapter<UserProfileEntity> {
  @override
  final int typeId = 1;

  @override
  UserProfileEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileEntity(
      userEmail: fields[0] as String,
      userName: fields[1] as String?,
      userIntro: fields[2] as String?,
      skills: (fields[3] as List?)?.cast<String>(),
      userExperience: fields[4] as String?,
      userProfilePic: fields[5] as File?,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userEmail)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.userIntro)
      ..writeByte(3)
      ..write(obj.skills)
      ..writeByte(4)
      ..write(obj.userExperience)
      ..writeByte(5)
      ..write(obj.userProfilePic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
