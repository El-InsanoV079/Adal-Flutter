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
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: BotonAnimado(
              texto: texto,
              esOperador: _esOperador(texto),
              esEspecial: _esEspecial(texto),
              onTap: () => _onBotonPresionado(texto),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xff0f172a), 
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 480, 
            ),
            child: Column(
              children: [
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
                          color: Color(0xff38bdf8),
                        ),
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    children: [
                      _filaBotones(['C', '√', '÷']), 
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
        ),
      ),
    );
  }
} 

class BotonAnimado extends StatefulWidget {
  final String texto;
  final bool esOperador;
  final bool esEspecial;
  final VoidCallback onTap;

  const BotonAnimado({
    super.key,
    required this.texto,
    required this.esOperador,
    required this.esEspecial,
    required this.onTap,
  });

  @override
  State<BotonAnimado> createState() => _BotonAnimadoState();
}

class _BotonAnimadoState extends State<BotonAnimado> {
  bool _estaPresionado = false;

  @override
  Widget build(BuildContext context) {
    Color fondoBoton = const Color(0xff1e293b);
    Color colorTexto = CupertinoColors.white;

    if (widget.esOperador) {
      fondoBoton = widget.texto == '=' ? const Color(0xff10b981) : const Color(0xff6366f1);
    } else if (widget.esEspecial) {
      fondoBoton = const Color(0xffef4444);
    }

    return GestureDetector(
      onTapDown: (_) => setState(() => _estaPresionado = true),
      onTapUp: (_) => setState(() => _estaPresionado = false),
      onTapCancel: () => setState(() => _estaPresionado = false),
      onTap: widget.onTap,
      
      child: AnimatedScale(
        scale: _estaPresionado ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          height: 75,
          decoration: BoxDecoration(
            color: _estaPresionado ? fondoBoton.withOpacity(0.8) : fondoBoton,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: _estaPresionado ? fondoBoton.withOpacity(0.1) : fondoBoton.withOpacity(0.3),
                blurRadius: _estaPresionado ? 4 : 12,
                offset: _estaPresionado ? const Offset(0, 1) : const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.texto,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: colorTexto,
              ),
            ),
          ),
        ),
      ),
    );
  }
}