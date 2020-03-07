import 'package:flutter/material.dart';

import 'loading_notification.dart';
import 'loading_notification_state.dart';

class LoadingFutureBuilder<T> extends StatefulWidget {
  LoadingFutureBuilder({
    @required this.key,
    @required this.future,
    @required this.builder,
    this.initialData,
  });

  final Key key;
  final T initialData;
  final Future<T> future;
  final AsyncWidgetBuilder<T> builder;

  @override
  _LoadingFutureBuilderState<T> createState() =>
      _LoadingFutureBuilderState<T>();
}

class _LoadingFutureBuilderState<T>
    extends LoadingNotificationState<LoadingFutureBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future.then((value) async {
        dispatchDidLoad();
        return value;
      }),
      initialData: widget.initialData,
      builder: widget.builder,
    );
  }
}
