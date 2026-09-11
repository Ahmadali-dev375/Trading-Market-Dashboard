// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TopUp extends StatefulWidget {
  const TopUp({super.key});

  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a35),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a35),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Top Up',
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
                  Icons.account_balance_wallet_outlined,
                  size: 64,
                  color: Color(0xffFBC700),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Top Up (Demo Placeholder)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'This screen is a placeholder in this portfolio showcase.\nThis application does not manage real funds, process deposits, or connect to banking services.',
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
