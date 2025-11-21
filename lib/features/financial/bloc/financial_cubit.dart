import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/bloc/error_handling_mixin.dart';

part 'financial_state.dart';

class FinancialCubit extends Cubit<FinancialState>
    with ErrorHandlingMixin<FinancialState> {
  FinancialCubit() : super(const FinancialState.initial());

  Future<void> loadFinancialData() async {
    emit(state.copyWith(status: FinancialStatus.loading));
    // Simulate loading
    await Future.delayed(const Duration(seconds: 1));
    emit(
      state.copyWith(
        status: FinancialStatus.success,
        transactions: ['Transaction 1', 'Transaction 2', 'Transaction 3'],
      ),
    );
  }
}
