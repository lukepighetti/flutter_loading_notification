import 'package:flutter/material.dart';
import 'package:loading_notification/loading_notification.dart';

void main() {
  runApp(LoadingNotificationsExample());
}

class LoadingNotificationsExample extends StatefulWidget {
  @override
  _LoadingNotificationsExampleState createState() =>
      _LoadingNotificationsExampleState();
}

class _LoadingNotificationsExampleState
    extends State<LoadingNotificationsExample> {
  final _groupOne = {
    "1000": Duration(milliseconds: 1000),
    "1250": Duration(milliseconds: 1250),
    "1500": Duration(milliseconds: 1500),
    "1750": Duration(milliseconds: 1750),
  };

  bool _isLoading = true;

  void _handleLoaded() {
    print("Loaded!");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("loading_notification"),
        ),
        body: Center(
          child: LoadingNotificationListener(
            onLoaded: _handleLoaded,
            child: Column(
              children: [
                Text(_isLoading ? "All still loading..." : "All done!"),
                SizedBox(height: 16),

                /// Group One
                LoadingNotificationListener(
                  key: Key("Group 1"),
                  child: Column(
                    children: <Widget>[
                      Text("FutureBuilders"),
                      ..._groupOne.entries.map<Widget>((e) {
                        return LoadingFutureBuilder<String>(
                          key: Key(e.key),
                          future: Future<String>.delayed(e.value)
                              .then((_) => e.key),
                          initialData: "Loading...",
                          builder: (context, snap) {
                            return Text(snap.data ?? "Wat");
                          },
                        );
                      })
                    ],
                  ),
                ),

                SizedBox(height: 32),

                /// Images
                LoadingNotificationListener(
                  key: Key("Images"),
                  child: Column(
                    children: <Widget>[
                      Text("Images"),
                      LoadingImage(
                        key: Key("Image 1"),
                        width: 100,
                        height: 100,
                        image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg",
                        ),
                      ),
                      LoadingImage(
                        key: Key("Image 2"),
                        width: 100,
                        height: 100,
                        image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
