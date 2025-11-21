import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/dashboard/bloc/dashboard_cubit.dart';
import 'package:app/features/dashboard/view/views/dashboard_content_view.dart';

class DashboardPage extends StatelessWidget {
  static const routePath = '/';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>()..loadDashboard(),
      child: DashboardContentView(),
    );
  }
}
