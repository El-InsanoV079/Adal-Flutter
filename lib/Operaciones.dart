import 'dart:math';

class CalculadoraLogic {
  String expresion = '';
  String resultado = '0';
  double? _primerOperando;
  String? _operador;
  bool _debeReiniciarPantalla = false;

  void procesarBoton(String texto) {
    if (texto == 'C') {
      expresion = '';
      resultado = '0';
      _primerOperando = null;
      _operador = null;
      _debeReiniciarPantalla = false;
    } else if (texto == '√') {
      double valor = double.tryParse(resultado) ?? 0;
      if (valor >= 0) {
        double raiz = sqrt(valor);
        
        resultado = raiz % 1 == 0 ? raiz.toInt().toString() : raiz.toStringAsFixed(4);
      } else {
        resultado = 'Error';
      }
      _debeReiniciarPantalla = true;
    } else if (texto == '+' || texto == '-' || texto == '×' || texto == '÷') {
      _primerOperando = double.tryParse(resultado);
      _operador = texto;
      _debeReiniciarPantalla = true;
    } else if (texto == '=') {
      if (_operador == null || _primerOperando == null) return;
      double segundoOperando = double.tryParse(resultado) ?? 0;
      double calculo = 0;

      switch (_operador) {
        case '+': calculo = _primerOperando! + segundoOperando; break;
        case '-': calculo = _primerOperando! - segundoOperando; break;
        case '×': calculo = _primerOperando! * segundoOperando; break;
        case '÷': 
          if (segundoOperando == 0) {
            resultado = 'Error';
            _operador = null;
            return;
          }
          calculo = _primerOperando! / segundoOperando; 
          break;
      }

      resultado = calculo % 1 == 0 ? calculo.toInt().toString() : calculo.toStringAsFixed(4);
      _operador = null;
      _primerOperando = null;
      _debeReiniciarPantalla = true;
    } else {

      if (_debeReiniciarPantalla) {
        resultado = texto == '.' ? '0.' : texto;
        _debeReiniciarPantalla = false;
      } else {
        if (resultado == '0' && texto != '.') {
          resultado = texto;
        } else {
          if (texto == '.' && resultado.contains('.')) return;
          resultado += texto;
        }
      }
    }
  }
}