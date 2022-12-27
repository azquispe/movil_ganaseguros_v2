import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movil_ganaseguros/solicitar_seguro/models/solicitud_seguro_model.dart';
import 'package:movil_ganaseguros/utils/api.dart' as api;
class SolicitaSeguroService {
  Future<bool> enviarSolicitudSeguro(
      SolicitudSeguroModel solicitudSeguroModel) async {
    const url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/solicitud-seguro";
    final contenido = jsonEncode(<String, String>{
      'nombres': solicitudSeguroModel.nombres != null? solicitudSeguroModel.nombres.toString(): "",
      'apellidos': solicitudSeguroModel.apellidos != null? solicitudSeguroModel.apellidos.toString(): "",
      'telefonoCelular': solicitudSeguroModel.telefonoCelular != null? solicitudSeguroModel.telefonoCelular.toString(): "",
      'correo': solicitudSeguroModel.correo != null? solicitudSeguroModel.correo.toString(): "",
      'ciudadId': solicitudSeguroModel.ciudadId != null? solicitudSeguroModel.ciudadId.toString(): "",
      'tipoProductoId': solicitudSeguroModel.tipoProductoId != null? solicitudSeguroModel.tipoProductoId.toString(): "",
      'tieneSeguroNosotros': solicitudSeguroModel.tieneSeguroNosotros != null? solicitudSeguroModel.tieneSeguroNosotros.toString(): "",
      'tieneSeguroOtros': solicitudSeguroModel.tieneSeguroOtros != null? solicitudSeguroModel.tieneSeguroOtros.toString(): "",
      'descripcion':solicitudSeguroModel.descripcion != null? solicitudSeguroModel.descripcion.toString(): "",
      "aplicacionId":"1003" // 1003 => Movil, 1002 => Web


    });
    print("==== TRAMA PARA SOLICITAR SEGURO ========");
    print(contenido);
    final response = await http
        .post(
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
}