// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a35),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a35),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings & Account',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlueAccent,
                      width: 6,
                    ),
                    color: const Color(0xFF0D47A1),
                    borderRadius: BorderRadius.circular(75),
                  ),
                  child: const Center(
                    child: Text(
                      '\$',
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 90,
                        fontWeight: FontWeight.w900,
                        shadows: [
                          Shadow(
                            offset: Offset(4.0, 4.0),
                            blurRadius: 8.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Crypto Dashboard',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Portfolio Showcase Demo\nAuthentication and account features are intentionally not connected in this public demo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white60,
                    height: 1.4,
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
