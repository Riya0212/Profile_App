import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iml_test_app/features/dashboard/domain/entitities/user_profile_entity.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitial());

  void navigateToAuthentication() {
    emit(NavigateToAuthenticationState());
  }

  void navigateToDashboard(UserProfileEntity userData) {
    emit(NavigateToDashboardState(userProfileData: userData));
  }
}
