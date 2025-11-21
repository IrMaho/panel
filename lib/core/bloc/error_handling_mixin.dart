import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';
import 'package:app/core/model/result.dart';
import 'package:app/core/router.dart';

mixin ErrorHandlingMixin<T> on Cubit<T> {
  void handleError(String errorMessage, {VoidCallback? onError}) {
    if (rootNavigatorKey.currentContext == null) return;

    toastification.show(
      context: rootNavigatorKey.currentContext!,
      type: ToastificationType.error,
      title: Text(errorMessage),
      autoCloseDuration: const Duration(seconds: 3),
      showProgressBar: true,
    );

    onError?.call();
  }

  void showSuccess(String message) {
    if (rootNavigatorKey.currentContext == null) return;

    toastification.show(
      context: rootNavigatorKey.currentContext!,
      type: ToastificationType.success,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 2),
    );
  }

  Future<void> executeWithErrorHandling<R>(
    Future<Result<R>> Function() operation,
    void Function(R data) onSuccess,
  ) async {
    final result = await operation();

    switch (result) {
      case Success(:final data):
        onSuccess(data);
      case Failure(:final message):
        handleError(message);
    }
  }
}
