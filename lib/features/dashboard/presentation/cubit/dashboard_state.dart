part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {
   final UserProfileEntity? currentUser;

  const DashboardInitial({required this.currentUser});
}

final class DashboardLoaded extends DashboardState {
  final UserProfileEntity? currentUser;

  final List<String?>? skillsList;

  const DashboardLoaded({
    required this.currentUser,
    required this.skillsList,
  });
}

final class DashboardLoading extends DashboardState {}

final class DashboardLogout extends DashboardState {}
