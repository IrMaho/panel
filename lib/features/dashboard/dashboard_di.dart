import 'package:get_it/get_it.dart';
import 'package:app/features/dashboard/bloc/dashboard_cubit.dart';

void setupDashboardDI(GetIt getIt) {
  getIt.registerFactory(() => DashboardCubit());
}
