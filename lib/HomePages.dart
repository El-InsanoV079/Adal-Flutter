import 'package:flutter/cupertino.dart';
import 'Operaciones.dart';

class Homepages extends StatefulWidget {
  const Homepages({super.key});

  @override
  State<Homepages> createState() => _HomepagesState();
}

class _HomepagesState extends State<Homepages> {
  final CalculadoraLogic _logic = CalculadoraLogic();

  bool _esOperador(String texto) {
    return texto == '+' || texto == '-' || texto == '×' || texto == '÷' || texto == '=' || texto == '√';
  }

  bool _esEspecial(String texto) {
    return texto == 'C';
  }

  void _onBotonPresionado(String texto) {
    setState(() {
      _logic.procesarBoton(texto);
    });
  }

  Widget _filaBotones(List<String> textos) {
    return Row(
      children: textos.map((texto) {
        final esOp = _esOperador(texto);
        final esEsp = _esEspecial(texto);

        // Asignación de colores para diseño Cyberpunk Premium
        Color fondoBoton = const Color(0xff1e293b); // Slate oscuro estándar
        Color colorTexto = CupertinoColors.white;

        if (esOp) {
          fondoBoton = texto == '=' ? const Color(0xff10b981) : const Color(0xff6366f1); // Esmeralda para '=', Índigo para operadores
        } else if (esEsp) {
          fondoBoton = const Color(0xffef4444); // Rojo para borrar 'C'
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => _onBotonPresionado(texto),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: 75,
                decoration: BoxDecoration(
                  color: fondoBoton,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: fondoBoton.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    texto,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: colorTexto,
                    ),
                  ),
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
      backgroundColor: const Color(0xff0f172a), // Fondo ultramoderno Slate 900
      child: SafeArea(
        child: Column(
          children: [
            // Pantalla de Visualización con diseño de cristalera
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(
                    _logic.resultado,
                    style: const TextStyle(
                      fontSize: 76, 
                      fontWeight: FontWeight.w200, 
                      color: Color(0xff38bdf8), // Texto neón cian
                    ),
                  ),
                ),
              ),
            ),
            
            // Teclado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  _filaBotones(['C', '√', '÷']), // Operaciones especiales arriba
                  _filaBotones(['7', '8', '9', '×']),
                  _filaBotones(['4', '5', '6', '-']),
                  _filaBotones(['1', '2', '3', '+']),
                  _filaBotones(['0', '.', '=']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}