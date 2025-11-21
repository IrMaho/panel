import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/accounting/bloc/accounting_cubit.dart';
import 'package:app/features/accounting/view/views/accounting_content_view.dart';

class AccountingPage extends StatelessWidget {
  static const routePath = '/accounting';

  const AccountingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AccountingCubit>()..loadAccountingData(),
      child: AccountingContentView(),
    );
  }
}
