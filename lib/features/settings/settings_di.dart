import 'package:get_it/get_it.dart';
import 'package:app/features/settings/bloc/settings_cubit.dart';

void setupSettingsDI(GetIt getIt) {
  getIt.registerFactory(() => SettingsCubit());
}
