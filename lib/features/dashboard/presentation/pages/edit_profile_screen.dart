import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iml_test_app/features/dashboard/presentation/cubit/dashboard_cubit.dart';

import '../../../../src/ui/utils/log_extension.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String route = 'EditProfileScreen';
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final log= logger;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        
        log.i(state);
      },
      builder: (context, state) {
         if (state is DashboardInitial) {
          BlocProvider.of<DashboardCubit>(context).fetchCurrentUser();
        }
        if (state is DashboardLoaded) {
          return Scaffold(
            body: Center(child: Text('hi ${state.currentUser!.userEmail}')),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('hi')),
          );
        }
      },
    );
  }
}
