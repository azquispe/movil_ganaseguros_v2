import 'dart:convert';

import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:http/http.dart' as http;
import 'package:movil_ganaseguros/utils/api.dart' as api;
class CambiarClaveService {
  Future<bool> cambiarClave(int pPersonaId, String pPasswordAnterior, String pPasswordNuevo) async {
    const url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/actualizar-clave";
    final contenido = jsonEncode(<String, String>{
      'personaId': pPersonaId.toString(),
      'passwordAnterior':pPasswordAnterior,
      'passwordNuevo': pPasswordNuevo
    });
    print("==== TRAMA PARA ACTUALIZAR CLAVE ========");
    print(contenido);
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: contenido,
    ).timeout(Duration(seconds: api.TIMEOUT_SECOND));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeData = json.decode(response.body) as Map<String, dynamic>;
      if (decodeData['codigoMensaje'].toString() == 'CODMW1000') {
        return true;
      } else {
        return false;
      }
    }else{
      return false;
    }
  }
}