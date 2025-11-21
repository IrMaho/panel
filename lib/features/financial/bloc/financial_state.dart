part of 'financial_cubit.dart';

enum FinancialStatus { initial, loading, success, error }

class FinancialState extends Equatable {
  final FinancialStatus status;
  final String? error;
  final List<String> transactions; // Placeholder for data

  const FinancialState({
    this.status = FinancialStatus.initial,
    this.error,
    this.transactions = const [],
  });

  const FinancialState.initial()
    : status = FinancialStatus.initial,
      error = null,
      transactions = const [];

  FinancialState copyWith({
    FinancialStatus? status,
    String? error,
    List<String>? transactions,
  }) {
    return FinancialState(
      status: status ?? this.status,
      error: error ?? this.error,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [status, error, transactions];
}
