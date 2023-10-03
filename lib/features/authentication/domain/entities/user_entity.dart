import 'package:hive/hive.dart';
part 'user_entity.g.dart';

@HiveType(typeId: 0)

///entity class for storing user login data
class UserEntity extends HiveObject {
  ///default constructor
  UserEntity( {
    required this.uemail,
    required this.upassword,
    required this.isRememberMe
  });
  @HiveField(0)

  ///user email
  final String? uemail;
  @HiveField(1)

  ///user password
  final String? upassword;

  @HiveField(2)
  //user rememberme option
  final bool isRememberMe;

  ///method
  List<dynamic> get props => <dynamic>[
        uemail,
        upassword,
        isRememberMe
      ];
}
