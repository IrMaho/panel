import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/financial/bloc/financial_cubit.dart';
import 'package:app/features/financial/view/views/financial_content_view.dart';

class FinancialPage extends StatelessWidget {
  static const routePath = '/financial';

  const FinancialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FinancialCubit>()..loadFinancialData(),
      child: FinancialContentView(),
    );
  }
}
