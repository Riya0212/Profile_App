import 'package:easy_localization/easy_localization.dart';

import '../../../generated/locale_keys.g.dart';

class ValidationUtils {
  ///email validation
  static String? emailValidator(String? email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
        .hasMatch(email?.trim() ?? '');
    if (email!.isEmpty || email == '') {
      return LocaleKeys.uname_empty_err.tr();
    } else if (emailValid == false) {
      return LocaleKeys.email_invalid_err.tr();
    } else {
      return null;
    }
  }

  ///password validation
  static String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return LocaleKeys.pass_empty_err.tr();
    } else if (password.length < 7) {
      return LocaleKeys.pass_len_err.tr();
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      return LocaleKeys.pass_lowercase_err.tr();
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return LocaleKeys.passs_uppercase_err.tr();
    } else if (!RegExp(r'[0-9]').hasMatch(password)) {
      return LocaleKeys.pass_digit_err.tr();
    } else if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return LocaleKeys.pass_specialcase_err.tr();
    } else {
      return null;
    }
  }

  static String? usernameValidator(String? username) {
    if (username!.isEmpty) {
      return LocaleKeys.uname_empty_err.tr();
    }
    return null;
  }

  static String? introValidator(String? introduction) {
    if (introduction!.isEmpty) {
      return LocaleKeys.intro_empty_err.tr();
    }
    return null;
  }

  static String? skillsValidator(String? skills) {
    if (skills!.isEmpty) {
      return LocaleKeys.skills_empty_err.tr();
    }
    return null;

    
  }
  static String? experienceValidator(String? experience) {
    if (experience!.isEmpty) {
      return LocaleKeys.experience_empty_err.tr();
    }
    else if(!RegExp(r'[0-9]').hasMatch(experience)){
      return LocaleKeys.experience_invalid.tr();

    }
    return null;
  }
  
}
