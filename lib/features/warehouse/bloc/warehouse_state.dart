part of 'warehouse_cubit.dart';

enum WarehouseStatus { initial, loading, success, error }

class WarehouseState extends Equatable {
  final WarehouseStatus status;
  final String? error;
  final List<String> items;

  const WarehouseState({
    this.status = WarehouseStatus.initial,
    this.error,
    this.items = const [],
  });

  const WarehouseState.initial()
    : status = WarehouseStatus.initial,
      error = null,
      items = const [];

  WarehouseState copyWith({
    WarehouseStatus? status,
    String? error,
    List<String>? items,
  }) {
    return WarehouseState(
      status: status ?? this.status,
      error: error ?? this.error,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [status, error, items];
}
