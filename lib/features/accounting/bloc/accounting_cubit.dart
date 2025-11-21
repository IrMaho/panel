import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/bloc/error_handling_mixin.dart';

part 'accounting_state.dart';

class AccountingCubit extends Cubit<AccountingState>
    with ErrorHandlingMixin<AccountingState> {
  AccountingCubit() : super(const AccountingState.initial());

  Future<void> loadAccountingData() async {
    emit(state.copyWith(status: AccountingStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(
      state.copyWith(
        status: AccountingStatus.success,
        invoices: ['Invoice #001', 'Invoice #002', 'Invoice #003'],
      ),
    );
  }
}
