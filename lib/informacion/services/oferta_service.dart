import 'dart:convert';

import 'package:movil_ganaseguros/avisos/models/aviso_model.dart';
import 'package:http/http.dart' as http;
import 'package:movil_ganaseguros/informacion/models/oferta_model.dart';
import 'package:movil_ganaseguros/utils/api.dart' as api;
import 'dart:io';

class OfertaService {
  Future<List<OfertaModel>> obtenerOfertas() async {



    const url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/obtener-ofertas/1003";

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).timeout(Duration(seconds: api.TIMEOUT_SECOND));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeData =
          json.decode(response.body) as Map<String, dynamic>;

      if (decodeData['codigoMensaje'].toString() == 'CODMW1000') {
        final vDecodeData = json.decode(response.body)["ofertas"] as List;

        List<OfertaModel> lstOfertas =
            vDecodeData.map((obj) => OfertaModel.fromMap(obj)).toList();
        return lstOfertas;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
