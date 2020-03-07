import 'package:flutter/material.dart';

import 'loading_notification_state.dart';

class LoadingImage extends StatefulWidget {
  LoadingImage({
    @required this.key,
    @required this.image,
    this.frameBuilder,
    this.loadingBuilder,
    this.semanticLabel,
    this.excludeFromSemantics = false,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode,
    this.fit,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.centerSlice,
    this.matchTextDirection = false,
    this.gaplessPlayback = false,
    this.filterQuality = FilterQuality.low,
  });

  final Key key;
  final ImageProvider image;
  final Widget Function(BuildContext, Widget, int, bool) frameBuilder;
  final Widget Function(BuildContext, Widget, ImageChunkEvent) loadingBuilder;
  final String semanticLabel;
  final bool excludeFromSemantics;
  final double width;
  final double height;
  final Color color;
  final BlendMode colorBlendMode;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final Rect centerSlice;
  final bool matchTextDirection;
  final bool gaplessPlayback;
  final FilterQuality filterQuality;

  @override
  _LoadingImageState createState() => _LoadingImageState();
}

class _LoadingImageState extends LoadingNotificationState<LoadingImage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _asyncInit();
  }

  void _asyncInit() async {
    await precacheImage(widget.image, context);
    dispatchDidLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Image(
      image: widget.image,
      frameBuilder: widget.frameBuilder,
      loadingBuilder: widget.loadingBuilder,
      semanticLabel: widget.semanticLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      width: widget.width,
      height: widget.height,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      fit: widget.fit,
      alignment: widget.alignment,
      repeat: widget.repeat,
      centerSlice: widget.centerSlice,
      matchTextDirection: widget.matchTextDirection,
      gaplessPlayback: widget.gaplessPlayback,
      filterQuality: widget.filterQuality,
    );
  }
}
