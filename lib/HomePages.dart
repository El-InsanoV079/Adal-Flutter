import 'package:flutter/material.dart';

class Homepages extends StatelessWidget {
  const Homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),

      body: const Center(
        child: Text(
          'Hola Flutter',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}