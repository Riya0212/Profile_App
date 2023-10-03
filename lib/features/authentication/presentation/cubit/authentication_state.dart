part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  final UserEntity? userLoggedData;

  const AuthenticationInitial({this.userLoggedData});
}

///credential success/ login success
class AuthenticationSuccess extends AuthenticationState {
  final UserEntity userLoggedData;

  const AuthenticationSuccess({required this.userLoggedData});
}

///failure state
class AuthenticationFailure extends AuthenticationState {}

///loading state
class AuthenticationLoading extends AuthenticationState {}
