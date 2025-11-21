import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/bloc/error_handling_mixin.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState>
    with ErrorHandlingMixin<SettingsState> {
  SettingsCubit() : super(const SettingsState.initial());

  void loadSettings() {
    emit(state.copyWith(status: SettingsStatus.success));
  }
}
