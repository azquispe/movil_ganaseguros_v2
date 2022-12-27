import 'dart:convert';

import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:http/http.dart' as http;
import 'package:movil_ganaseguros/utils/api.dart' as api;
class DatosPersonaService {
  Future<bool> actualizarPersona(DatosPersonaModel pDatosPersonaModel) async {
    const url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/actualizar-usuario";
    final contenido = jsonEncode(<String, String>{
      'personaId': pDatosPersonaModel.personaId != null? pDatosPersonaModel.personaId.toString(): "",
      'generoId': pDatosPersonaModel.generoId != null? pDatosPersonaModel.generoId.toString(): "",
      'nombres': pDatosPersonaModel.nombres != null? pDatosPersonaModel.nombres.toString(): "",
      'apellidoPaterno': pDatosPersonaModel.apellidoPaterno != null? pDatosPersonaModel.apellidoPaterno.toString(): "",
      'apellidoMaterno': pDatosPersonaModel.apellidoMaterno != null? pDatosPersonaModel.apellidoMaterno.toString(): "",
      'numeroDocumento': pDatosPersonaModel.numeroDocumento != null? pDatosPersonaModel.numeroDocumento.toString(): "",
      'ciudadExpedidoId': pDatosPersonaModel.ciudadExpedidoId != null? pDatosPersonaModel.ciudadExpedidoId.toString(): "",
      'complemento': pDatosPersonaModel.complemento != null? pDatosPersonaModel.complemento.toString(): "",
      'numeroCelular':pDatosPersonaModel.numeroCelular != null? pDatosPersonaModel.numeroCelular.toString(): "",
      "correoElectronico":pDatosPersonaModel.correoElectronico != null? pDatosPersonaModel.correoElectronico.toString(): "",
      "fechaNacimiento":pDatosPersonaModel.fechaNacimiento != null? pDatosPersonaModel.fechaNacimiento.toString(): "",
    });
    print("==== TRAMA PARA ACTUALIZAR PERSONA ========");
    print(contenido);
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: contenido,
    )
        .timeout(Duration(seconds: api.TIMEOUT_SECOND));
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
  Future<DatosPersonaModel> obtenerPersona(int pPersonaId) async {
    String  url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/obtener-persona/"+pPersonaId.toString();
    final response = await http.get(Uri.parse(url),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',}).timeout(Duration(seconds: api.TIMEOUT_SECOND));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeData =
      json.decode(response.body) as Map<String, dynamic>;
      if (decodeData['codigoMensaje'].toString() == 'CODMW1000') {
        final Map<String, dynamic> vDecodeData =
        json.decode(response.body)["datosPersona"];
        DatosPersonaModel objDatosPersona = DatosPersonaModel.fromMap(vDecodeData);
        return objDatosPersona;
      } else {
        return new DatosPersonaModel();
      }
    }
    return new DatosPersonaModel();
  }
}