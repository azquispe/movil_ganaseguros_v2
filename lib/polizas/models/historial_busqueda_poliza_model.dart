// To parse this JSON data, do
//
//     final datosPersonasModel = datosPersonasModelFromMap(jsonString);

import 'dart:convert';

class HistorialBusquedaPolizaModel {
  HistorialBusquedaPolizaModel({
    this.historialBusquedaPolizaId,
    this.nroDocumento,
    this.ciudadExpedidoId, // ID
    this.complemento,
    this.nombreAsegurado,
    this.nombreTomador,
    this.fechaNacimiento,
  });

  int ? historialBusquedaPolizaId;
  String ? nroDocumento;
  int ? ciudadExpedidoId;
  String ? complemento;
  String ? nombreAsegurado;
  String ? nombreTomador;
  String ? fechaNacimiento;

  factory HistorialBusquedaPolizaModel.fromJson(String str) => HistorialBusquedaPolizaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistorialBusquedaPolizaModel.fromMap(Map<String, dynamic> json) => HistorialBusquedaPolizaModel(
    historialBusquedaPolizaId: json["historialBusquedaPolizaId"] == null ? null : json["historialBusquedaPolizaId"],
    nroDocumento: json["nroDocumento"] == null ? null : json["nroDocumento"],
    ciudadExpedidoId: json["ciudadExpedidoId"] == null ? null : json["ciudadExpedidoId"],
    complemento: json["complemento"] == null ? null : json["complemento"],
    nombreAsegurado: json["nombreAsegurado"] == null ? null : json["nombreAsegurado"],
    nombreTomador: json["nombreTomador"] == null ? null : json["nombreTomador"],
    fechaNacimiento: json["fechaNacimiento"] == null ? null : json["fechaNacimiento"],
  );

  Map<String, dynamic> toMap() => {
    "historialBusquedaPolizaId": historialBusquedaPolizaId == null ? null : historialBusquedaPolizaId,
    "nroDocumento": nroDocumento == null ? null : nroDocumento,
    "ciudadExpedidoId": ciudadExpedidoId == null ? null : ciudadExpedidoId,
    "complemento": complemento == null ? null : complemento,
    "nombreAsegurado": nombreAsegurado == null ? null : nombreAsegurado,
    "nombreTomador": nombreTomador == null ? null : nombreTomador,
    "fechaNacimiento": fechaNacimiento == null ? null : fechaNacimiento,
  };
}
