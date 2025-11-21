import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/core/theme/theme_cubit.dart';
import 'package:app/core/locale/locale_cubit.dart';
import 'package:app/features/dashboard/dashboard_di.dart';
import 'package:app/features/financial/financial_di.dart';
import 'package:app/features/warehouse/warehouse_di.dart';
import 'package:app/features/accounting/accounting_di.dart';
import 'package:app/features/settings/settings_di.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Core
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton(() => ThemeCubit(getIt<SharedPreferences>()));
  getIt.registerLazySingleton(() => LocaleCubit(getIt<SharedPreferences>()));

  // Features
  setupDashboardDI(getIt);
  setupFinancialDI(getIt);
  setupWarehouseDI(getIt);
  setupAccountingDI(getIt);
  setupSettingsDI(getIt);
}
