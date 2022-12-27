import 'dart:convert';

import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:movil_ganaseguros/utils/models/dominio_model.dart';
import 'package:movil_ganaseguros/utils/file_process.dart';

import 'package:http/http.dart' as http;
import 'package:movil_ganaseguros/utils/api.dart' as api;

import 'dart:io';

class LoginService {
  Future<DatosPersonaModel> login(String usuario, String password) async {
    const url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/autentication";
    final response = await http
        .post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'login': usuario != null ? usuario.toString() : "",
            'password': password != null ? password.toString() : "",
          }),
        )
        .timeout(Duration(seconds: api.TIMEOUT_SECOND));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeData =
          json.decode(response.body) as Map<String, dynamic>;
      if (decodeData['codigoMensaje'].toString() == 'CODMW1000') {
        final Map<String, dynamic> vDecodeData =
            json.decode(response.body)["datosPersona"];
        DatosPersonaModel objDatosPersona =
            DatosPersonaModel.fromMap(vDecodeData);
        return objDatosPersona;
      } else {
        return new DatosPersonaModel();
      }
    }
    return new DatosPersonaModel();
  }


}
