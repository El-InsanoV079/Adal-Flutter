import 'package:flutter/cupertino.dart';

class Homepages extends StatelessWidget {
  const Homepages({super.key});

  static bool _esOperador(String texto) {
    return texto == '+' ||
        texto == '-' ||
        texto == '×' ||
        texto == '÷' ||
        texto == '=';
  }

  static Widget _filaBotones(List<String> textos) {
    return Row(
      children: textos.map((texto) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: CupertinoButton(
              color: _esOperador(texto)
                  ? CupertinoColors.systemOrange
                  : CupertinoColors.systemGrey5,
              borderRadius: BorderRadius.circular(40),
              onPressed: () {},
              child: Text(
                texto,
                style: TextStyle(
                  fontSize: 28,
                  color: _esOperador(texto)
                      ? CupertinoColors.white
                      : CupertinoColors.black,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Calculadora iOS'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: const Text(
                  '0',
                  style: TextStyle(fontSize: 64, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            _filaBotones(['7', '8', '9', '÷']),
            _filaBotones(['4', '5', '6', '×']),
            _filaBotones(['1', '2', '3', '-']),
            _filaBotones(['0', '.', '=', '+']),
          ],
        ),
      ),
    );
  }
}