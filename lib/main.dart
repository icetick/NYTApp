import 'package:flutter/material.dart';
import 'package:NYT/mainPage.dart';

import 'networking/networkManager.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final NetworkManager manager = NetworkManager();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'NYT',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: MainPage(manager: manager),
    );
  }
}