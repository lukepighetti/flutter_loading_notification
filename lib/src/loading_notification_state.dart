import 'package:flutter/material.dart';

import 'loading_notification.dart';

/// Used to create StatefulWidgets that notify their ancestors of their loading state
abstract class LoadingNotificationState<T extends StatefulWidget>
    extends State<T> {
  bool _didDispatchIsLoading = false;

  @override
  void didChangeDependencies() {
    if (_didDispatchIsLoading == false) {
      WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
        LoadingNotification(widget.key, true).dispatch(context);
      });

      _didDispatchIsLoading = true;
    }

    super.didChangeDependencies();
  }

  /// Call this when the widget has finished loading, whatever the heck that means.
  void dispatchDidLoad() {
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      LoadingNotification(widget.key, false).dispatch(context);
    });
  }
}
