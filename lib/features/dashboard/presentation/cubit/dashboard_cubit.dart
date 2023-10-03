import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iml_test_app/features/dashboard/domain/entitities/user_profile_entity.dart';
import 'package:iml_test_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:iml_test_app/src/ui/utils/log_extension.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required this.repository})
      : super(const DashboardInitial(currentUser: null));

  final DashboardRepository repository;

  final log = logger;
  void fetchCurrentUser() async {
    emit(DashboardLoading());

    try {
      final currentUser = await repository.getCurrentUser();
      if (currentUser != null) {}
      // emit(DashboardInitial(currentUser: currentUser));

      emit(DashboardLoaded(currentUser: currentUser, skillsList: null));
    } on Exception catch(_){}
  }

  void addSkill(String newskill) async {
    try {
      final currentUser = await repository.getCurrentUser();
      final List<String> allSkills = await repository.addSkills(newskill);

      log.i(allSkills);
      emit(DashboardLoaded(currentUser: currentUser!, skillsList: allSkills));
    } on Exception catch(_) {}
  }

  void saveUser(UserProfileEntity userProfileEntity) async {
    try {
      await repository.saveUserProfile(userProfileEntity);
      emit(DashboardLoaded(currentUser: userProfileEntity, skillsList: null));
    } on Exception catch (_) {}
  }

  void logoutUser() async {
    try {
      await repository.logout();
      log.i('logged out'); // Invoke the function and await the returned Future.
      emit(DashboardLogout());
    } on Exception catch (_) {
      // Handle exceptions as needed.
    }
  }

  // void logoutUser() async {
  //   // try {
  //   //   final isgoogleSignin = repository.getIfGoogleSignIn;
  //   //   if (isgoogleSignin == true) {
  //   //     await repository.googleLogout();
  //   //     emit(DashboardLogout());
  //   //   } else {
  //   //     emit(DashboardLogout());
  //   //   }
  //   // } on Exception catch (_) {}

  //   try {
  //     await repository.logout;
  //     emit(DashboardLogout());
  //   } on Exception catch (_) {}
  // }
}
