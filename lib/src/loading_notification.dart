import 'package:flutter/material.dart';

class LoadingNotification extends Notification {
  LoadingNotification(this.key, this.isLoading);

  final Key key;
  final bool isLoading;
}
