import 'package:get_it/get_it.dart';
import 'package:app/features/financial/bloc/financial_cubit.dart';

void setupFinancialDI(GetIt getIt) {
  getIt.registerFactory(() => FinancialCubit());
}
