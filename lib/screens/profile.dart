import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a35),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a35),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF211f40),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 64,
                  color: Color(0xffFBC700),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'User Profile (Demo Placeholder)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This screen is a placeholder in this portfolio showcase.\nUser accounts and server authentication are not implemented.',
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
    );
  }
}
