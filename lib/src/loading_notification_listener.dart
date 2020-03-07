import 'package:flutter/material.dart';

import 'loading_notification.dart';
import 'loading_notification_state.dart';

class LoadingNotificationListener extends StatefulWidget {
  const LoadingNotificationListener(
      {this.key, this.onLoaded, @required this.child})
      : super(key: key);

  /// All keys must be unique within all child widgets that use [LoadingNotification]
  final Key key;

  /// If `onLoaded` is `null`, we will pass a notification for this
  /// onLoaded event to an ancestor [LoadingNotificationListener]
  ///
  /// If `onLoaded` is a function, we will pass the onLoaded event to the
  /// `onLoaded` callback.
  final VoidCallback onLoaded;

  final Widget child;

  @override
  _LoadingNotificationListenerState createState() =>
      _LoadingNotificationListenerState();
}

class _LoadingNotificationListenerState
    extends LoadingNotificationState<LoadingNotificationListener> {
  final _isLoadingStore = Map<Key, bool>();

  bool _hasCalledOnLoaded = false;

  bool _handleNotification(LoadingNotification notification) {
    _isLoadingStore[notification.key] = notification.isLoading;

    final isLoading = _isLoadingStore.values.any((e) => e == true);

    if (isLoading == false && _hasCalledOnLoaded == false) {
      if (widget.onLoaded != null) {
        widget.onLoaded();
      } else {
        dispatchDidLoad();
      }

      _hasCalledOnLoaded = true;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<LoadingNotification>(
      onNotification: _handleNotification,
      child: widget.child,
    );
  }
}
