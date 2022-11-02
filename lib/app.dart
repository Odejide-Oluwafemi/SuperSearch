import 'package:flutter/material.dart';
import 'package:super_search/screens/search/search.dart';
import 'style.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colorful Search',
      theme: appTheme,
      home: const Search(),
    );
  }
}
