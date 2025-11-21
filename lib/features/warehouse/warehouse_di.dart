import 'package:get_it/get_it.dart';
import 'package:app/features/warehouse/bloc/warehouse_cubit.dart';

void setupWarehouseDI(GetIt getIt) {
  getIt.registerFactory(() => WarehouseCubit());
}
