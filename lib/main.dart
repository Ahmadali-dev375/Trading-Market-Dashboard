// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screens/bottombar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Dashboard',
      theme: ThemeData(
        drawerTheme: DrawerThemeData(backgroundColor: Color(0xFF211f40)),
        cardTheme: CardThemeData(color: Color(0xFF1a1a35)),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF1a1a35)),
        scaffoldBackgroundColor: const Color(0xFF1a1a35),
      ),
      home: const NavBar(),
    );
  }
}
