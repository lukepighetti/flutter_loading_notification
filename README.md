# loading_notification

Uses Flutter Notifications to bubble up `isLoading` events. Good for showing a loading screen until all the containing Image / FutureBuilder widgets inside it have completed. 


## Crash course

Wrap multiple `LoadingImage` and/or `LoadingFutureBuilder` with a `LoadingNotificationListener`. When all of it's children are done loading, it will fire the `onLoaded` callback.

PRO TIP: You can create loading groups by nesting `LoadingNotificationListeners`. If you leave the `onLoaded` callback empty, it will bubble the event to it's ancestors.

```dart
LoadingNotificationListener(
  key: Key("Images"),
  onLoaded: _handleLoaded,
  child: Column(
    children: <Widget>[
      Text("Images"),
      LoadingFutureBuilder<String>(
        key: Key("Future A"),
        future: Future<String>.delayed(Duration(seconds: 1))
            .then((_) => "Loaded!"),
        initialData: "Loading...",
        builder: (context, snap) {
          return Text(snap.data ?? "Wat");
        },
      ),
      LoadingImage(
        key: Key("Image A"),
        width: 100,
        height: 100,
        image: NetworkImage(
          "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg",
        ),
      ),
    ],
  ),
),
```