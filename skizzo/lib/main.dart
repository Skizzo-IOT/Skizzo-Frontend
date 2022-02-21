import 'package:flutter/material.dart';
import 'package:skizzo/screens/connection.dart';
import 'package:skizzo/themes.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Connection(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skizzo',
      theme: theme(),
      initialRoute: Connection.route,
      routes: {
        Connection.route: (context) => const Connection(),
      },
    );
  }
}
