import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites.dart';
import '../screens/favorites.dart';
import '../screens/home.dart';

void main() {
  runApp(const TestingApp());
}

class TestingApp extends StatelessWidget {
  const TestingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp(
        title: 'Testing Sample',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          FavoritesPage.routeName: (context) => const FavoritesPage(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}
