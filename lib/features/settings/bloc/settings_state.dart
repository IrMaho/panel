part of 'settings_cubit.dart';

enum SettingsStatus { initial, loading, success, error }

class SettingsState extends Equatable {
  final SettingsStatus status;
  final String? error;

  const SettingsState({this.status = SettingsStatus.initial, this.error});

  const SettingsState.initial() : status = SettingsStatus.initial, error = null;

  SettingsState copyWith({SettingsStatus? status, String? error}) {
    return SettingsState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
