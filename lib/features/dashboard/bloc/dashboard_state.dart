part of 'dashboard_cubit.dart';

enum DashboardStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final String? error;

  const DashboardState({this.status = DashboardStatus.initial, this.error});

  const DashboardState.initial()
    : status = DashboardStatus.initial,
      error = null;

  DashboardState copyWith({DashboardStatus? status, String? error}) {
    return DashboardState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
