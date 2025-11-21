import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin StreamMixin<T, S> on Cubit<S> {
  StreamSubscription<T>? _subscription;

  void listenToStream(
    Stream<T> stream,
    void Function(T data) onData, {
    void Function(Object error)? onError,
  }) {
    // Cancel existing subscription
    _subscription?.cancel();

    // Create new subscription
    _subscription = stream.listen(
      onData,
      onError:
          onError ??
          (error) {
            // Default error handling
            print('Stream error: $error');
          },
    );
  }

  void cancelStream() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
