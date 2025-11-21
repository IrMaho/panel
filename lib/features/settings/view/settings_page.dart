import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/settings/bloc/settings_cubit.dart';
import 'package:app/features/settings/view/views/settings_content_view.dart';

class SettingsPage extends StatelessWidget {
  static const routePath = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SettingsCubit>()..loadSettings(),
      child: SettingsContentView(),
    );
  }
}
