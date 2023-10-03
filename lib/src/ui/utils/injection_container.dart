import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iml_test_app/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:iml_test_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:iml_test_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:iml_test_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:iml_test_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:iml_test_app/features/navigation/cubit/navigation_cubit.dart';

import '../../../features/authentication/presentation/cubit/authentication_cubit.dart';

final GetIt serviceLocater = GetIt.instance;

///method for initialization
Future<void> init() async {
  ///bloc

  serviceLocater.registerFactory<AuthenticationCubit>(
      () => AuthenticationCubit(repository: serviceLocater<AuthRepository>()));
  serviceLocater.registerFactory<NavigationCubit>(() => NavigationCubit());

  serviceLocater.registerFactory<DashboardCubit>(
      () => DashboardCubit(repository: serviceLocater<DashboardRepository>()));

  ///repositories
  serviceLocater.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      googleSignIn: serviceLocater.call(), auth: serviceLocater.call()));

  serviceLocater.registerLazySingleton<DashboardRepository>(() =>
      DashboardRepositoryImpl(
          googleSignIn: serviceLocater.call(), auth: serviceLocater.call()));

  final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  serviceLocater
    ..registerLazySingleton(() => auth)
    ..registerLazySingleton(() => googleSignIn);
}
