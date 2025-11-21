import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/di/service_locator.dart';
import 'package:app/features/warehouse/bloc/warehouse_cubit.dart';
import 'package:app/features/warehouse/view/views/warehouse_content_view.dart';

class WarehousePage extends StatelessWidget {
  static const routePath = '/warehouse';

  const WarehousePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WarehouseCubit>()..loadWarehouseData(),
      child: WarehouseContentView(),
    );
  }
}
