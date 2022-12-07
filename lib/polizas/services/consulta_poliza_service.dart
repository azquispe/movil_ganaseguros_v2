import 'dart:convert';

import 'package:movil_ganaseguros/models/request_poliza_model.dart';
import 'package:movil_ganaseguros/models/solicitud_seguro_model.dart';
import 'package:movil_ganaseguros/utils/file_process.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movil_ganaseguros/utils/api.dart' as api;

import '../models/poliza_model.dart';
import 'dart:io';
import 'dart:typed_data';

class ConsultaPolizasService {
  Future<List<PolizaModel>> obtenerPolizasPorNroDocumento(RequestPolizaModel pRequestPolizaModel) async {
    const url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/consulta-poliza";

    final response = await http
        .post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'nroDocumento': pRequestPolizaModel.nroDocumento != null
                ? pRequestPolizaModel.nroDocumento.toString()
                : "",
            'extension': pRequestPolizaModel.extension != null
                ? pRequestPolizaModel.extension.toString()
                : "",
            'complemento': pRequestPolizaModel.complemento != null
                ? pRequestPolizaModel.complemento.toString()
                : "",
            'fechaNacimiento': pRequestPolizaModel.fechaNacimiento != null
                ? pRequestPolizaModel.fechaNacimiento.toString()
                : "",
          }),
        )
        .timeout(Duration(seconds: api.TIMEOUT_SECOND));

    if (response.statusCode == 200) {

      final Map<String, dynamic> decodeData = json.decode(response.body) as Map<String, dynamic>;
      if (decodeData['codigoMensaje'].toString() == 'CODMW1000') {
        final vDecodeData = json.decode(response.body)["datosPoliza"] as List;

        List<PolizaModel> lstPolizas = vDecodeData.map((obj) => PolizaModel.fromMap(obj)).toList();
        return lstPolizas;
      } else {
        return [];
      }

    }
    return [];
  }

  Future<bool> enviarSolicitudSeguro(
      SolicitudSeguroModel solicitudSeguroModel) async {
    const url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/solicitud-seguro";

    final response = await http
        .post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'nombres': solicitudSeguroModel.nombres != null? solicitudSeguroModel.nombres.toString(): "",
            'apellidos': solicitudSeguroModel.apellidos != null? solicitudSeguroModel.apellidos.toString(): "",
            'telefonoCelular': solicitudSeguroModel.telefonoCelular != null? solicitudSeguroModel.telefonoCelular.toString(): "",
            'correo': solicitudSeguroModel.correo != null? solicitudSeguroModel.correo.toString(): "",
            'ciudad': solicitudSeguroModel.ciudad != null? solicitudSeguroModel.ciudad.toString(): "",
            'tieneSeguroConNosotros': solicitudSeguroModel.tieneSeguroConNosotros != null? solicitudSeguroModel.tieneSeguroConNosotros.toString(): "",
            'tieneSeguroConOtros': solicitudSeguroModel.tieneSeguroConOtros != null? solicitudSeguroModel.tieneSeguroConOtros.toString(): "",
            'tipoSeguroInteresado': solicitudSeguroModel.tipoSeguroInteresado != null? solicitudSeguroModel.tipoSeguroInteresado.toString(): "",
            "tipoMedioSolicitudSeguro":'1003'
          }),
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

  Future<String?> descargarPoliza(String pPolicyId) async {

    final  url = "${api.API_MOVIL_GANASEGURO}/app-web/v1/descargar-poliza/" + pPolicyId;

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }).timeout(Duration(seconds: api.TIMEOUT_SECOND));
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeData = json.decode(response.body) as Map<String, dynamic>;

      if (decodeData['codigoMensaje'].toString() == 'CODMW1000') {
        String bs4str = decodeData['documento'];
        File file = await  FileProcess.downloadFile(bs4str,"poliza.pdf");

        return file.path;

      } else {
        return null;
      }
    }
    return null;
  }
}
