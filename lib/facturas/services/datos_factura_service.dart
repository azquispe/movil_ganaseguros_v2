import 'dart:convert';

import 'package:movil_ganaseguros/facturas/models/datos_factura_model.dart';
import 'package:http/http.dart' as http;
import 'package:movil_ganaseguros/utils/api.dart' as api;
import 'dart:io';
import 'package:movil_ganaseguros/utils/file_process.dart';

class DatosFacturaService {
  Future<List<DatosFacturaModel>> obtenerDatosFactura(Map<String,dynamic> pRequestDatosFacturaModel) async {
    const url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/consulta-facturas";

    final contenido =  jsonEncode(<String, String>{
      'nroDocumento': pRequestDatosFacturaModel['nroDocumento'] != null
          ? pRequestDatosFacturaModel['nroDocumento'].toString()
          : "",
      'ciudadExpedidoId': pRequestDatosFacturaModel['ciudadExpedidoId'] != null
          ? pRequestDatosFacturaModel['ciudadExpedidoId'].toString()
          : "",
      'complemento': pRequestDatosFacturaModel['complemento'] != null
          ? pRequestDatosFacturaModel['complemento'].toString()
          : "",
      'fechaNacimiento': pRequestDatosFacturaModel['fechaNacimiento'] != null
          ? pRequestDatosFacturaModel['fechaNacimiento'].toString()
          : "",
    });
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:contenido,
    )
        .timeout(Duration(seconds: api.TIMEOUT_SECOND));
    print("==== TRAMA PARA CONSULTA DE FACTURAS ========");
    print(contenido);

    if (response.statusCode == 200) {

      final Map<String, dynamic> decodeData = json.decode(response.body) as Map<String, dynamic>;
      if (decodeData['codigoMensaje'].toString() == 'CODMW1000') {
        final vDecodeData = json.decode(response.body)["datosFactura"] as List;
        print("==== RESPUESTA FACTURAS ========");
        print(vDecodeData);
        List<DatosFacturaModel> lstDatosFacturas = vDecodeData.map((obj) => DatosFacturaModel.fromMap(obj)).toList();
        return lstDatosFacturas;
      } else {
        return [];
      }

    }
    return [];
  }


  Future<String?> descargarFactura() async {

    final  url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/descargar-factura";

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).timeout(Duration(seconds: api.TIMEOUT_SECOND));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeData = json.decode(response.body) as Map<String, dynamic>;

      if (decodeData['codigoMensaje'].toString() == 'CODMW1000') {
        String bs4str = decodeData['documento'];
        File file = await  FileProcess.downloadFile(bs4str,"factura.pdf");

        return file.path;

      } else {
        return null;
      }
    }
    return null;
  }
}