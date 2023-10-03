import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iml_test_app/features/authentication/domain/entities/user_entity.dart';
import 'package:iml_test_app/features/authentication/domain/repositories/auth_repository.dart';

import '../../../../src/ui/utils/log_extension.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required this.repository})
      : super(const AuthenticationInitial());

  final AuthRepository repository;

  final log = logger;

  Future<void> fetchCredentials() async {
    try {
      final UserEntity? userData = await repository.fetchCredentials();
      emit(AuthenticationInitial(userLoggedData: userData));
    } on Exception catch (e) {
      log.i(e);
      emit(AuthenticationFailure());
    }
  }

  Future<void> doGoogleSignIn() async {
    emit(AuthenticationLoading());
    try {
      final userData = await repository.googleSignedIn();
      emit(AuthenticationSuccess(userLoggedData: userData!));
    } on Exception catch (_) {}
  }

  Future<void> submitSignIn({required UserEntity userData}) async {
    emit(AuthenticationLoading());
    try {
      await repository.signIn(userData);
      emit(AuthenticationSuccess(userLoggedData: userData));
    } on Exception catch (e) {
      log.i(e);
      emit(AuthenticationFailure());
    }
  }

  Future<void> onSignOut() async {
    emit(AuthenticationLoading());
    try {
      await repository.signOut();
      emit(const AuthenticationInitial());
    } on Exception catch (_) {}
  }
}
