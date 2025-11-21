import 'package:get_it/get_it.dart';
import 'package:app/features/accounting/bloc/accounting_cubit.dart';

void setupAccountingDI(GetIt getIt) {
  getIt.registerFactory(() => AccountingCubit());
}
