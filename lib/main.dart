import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remoteokio/screens/screen.dart';
import 'package:remoteokio/states/remoteok_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RemoteokState(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RemoteokIo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RemoteokScreen(),
    );
  }
}
