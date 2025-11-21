part of 'accounting_cubit.dart';

enum AccountingStatus { initial, loading, success, error }

class AccountingState extends Equatable {
  final AccountingStatus status;
  final String? error;
  final List<String> invoices;

  const AccountingState({
    this.status = AccountingStatus.initial,
    this.error,
    this.invoices = const [],
  });

  const AccountingState.initial()
    : status = AccountingStatus.initial,
      error = null,
      invoices = const [];

  AccountingState copyWith({
    AccountingStatus? status,
    String? error,
    List<String>? invoices,
  }) {
    return AccountingState(
      status: status ?? this.status,
      error: error ?? this.error,
      invoices: invoices ?? this.invoices,
    );
  }

  @override
  List<Object?> get props => [status, error, invoices];
}
