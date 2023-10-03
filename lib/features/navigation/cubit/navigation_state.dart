part of 'navigation_cubit.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

final class NavigationInitial extends NavigationState {}
final class NavigateToAuthenticationState extends NavigationState {}

final class NavigateToDashboardState extends NavigationInitial {
  final UserProfileEntity userProfileData;

  NavigateToDashboardState({ required this.userProfileData});
}
