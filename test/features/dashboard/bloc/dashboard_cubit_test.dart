import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:app/features/dashboard/bloc/dashboard_cubit.dart';

void main() {
  group('DashboardCubit', () {
    late DashboardCubit cubit;

    setUp(() {
      cubit = DashboardCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is DashboardState.initial', () {
      expect(cubit.state, const DashboardState.initial());
    });

    blocTest<DashboardCubit, DashboardState>(
      'emits [loading, success] when loadDashboard is called',
      build: () => cubit,
      act: (cubit) => cubit.loadDashboard(),
      wait: const Duration(seconds: 1), // Wait for the delay in cubit
      expect: () => [
        const DashboardState(status: DashboardStatus.loading),
        const DashboardState(status: DashboardStatus.success),
      ],
    );
  });
}
