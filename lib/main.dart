import 'package:flutter/cupertino.dart';
import 'homepages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Calculadora iOS',
      home: Homepages(),
    );
  }
}