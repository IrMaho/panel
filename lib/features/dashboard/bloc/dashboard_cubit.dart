import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/bloc/error_handling_mixin.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState>
    with ErrorHandlingMixin<DashboardState> {
  DashboardCubit() : super(const DashboardState.initial());

  Future<void> loadDashboard() async {
    emit(state.copyWith(status: DashboardStatus.loading));
    // Simulate loading
    await Future.delayed(const Duration(seconds: 1));
    emit(state.copyWith(status: DashboardStatus.success));
  }
}
