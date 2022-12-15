import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;

class CircularProgressWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  CircularProgressIndicator(
      backgroundColor: colores.sec_negro_claro4,

      valueColor: AlwaysStoppedAnimation(colores.pri_verde_claro),
      strokeWidth: 5,
    );
  }
}
