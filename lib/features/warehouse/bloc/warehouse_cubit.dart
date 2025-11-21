import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:app/core/bloc/error_handling_mixin.dart';

part 'warehouse_state.dart';

class WarehouseCubit extends Cubit<WarehouseState>
    with ErrorHandlingMixin<WarehouseState> {
  WarehouseCubit() : super(const WarehouseState.initial());

  Future<void> loadWarehouseData() async {
    emit(state.copyWith(status: WarehouseStatus.loading));
    await Future.delayed(const Duration(seconds: 1));
    emit(
      state.copyWith(
        status: WarehouseStatus.success,
        items: ['Item A', 'Item B', 'Item C'],
      ),
    );
  }
}
