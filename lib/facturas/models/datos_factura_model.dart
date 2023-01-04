// To parse this JSON data, do
//
//     final datosFacturaModel = datosFacturaModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DatosFacturaModel {
  DatosFacturaModel({
    this.fechaFactura,
    this.nitEmisor,
    this.nombreComercial,
    this.numeroFactura,
    this.monto,
    this.urlFactura,
  });

  String ? fechaFactura;
  String ? nitEmisor;
  String ? nombreComercial;
  String ? numeroFactura;
  String ? monto;
  String ? urlFactura;

  factory DatosFacturaModel.fromJson(String str) => DatosFacturaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatosFacturaModel.fromMap(Map<String, dynamic> json) => DatosFacturaModel(
    fechaFactura: json["fechaFactura"] == null ? null : json["fechaFactura"],
    nitEmisor: json["nitEmisor"] == null ? null : json["nitEmisor"],
    nombreComercial: json["nombreComercial"] == null ? null : json["nombreComercial"],
    numeroFactura: json["numeroFactura"] == null ? null : json["numeroFactura"],
    monto: json["monto"] == null ? null : json["monto"],
    urlFactura: json["urlFactura"] == null ? null : json["urlFactura"],
  );

  Map<String, dynamic> toMap() => {
    "fechaFactura": fechaFactura == null ? null : fechaFactura,
    "nitEmisor": nitEmisor == null ? null : nitEmisor,
    "nombreComercial": nombreComercial == null ? null : nombreComercial,
    "numeroFactura": numeroFactura == null ? null : numeroFactura,
    "monto": monto == null ? null : monto,
    "urlFactura": urlFactura == null ? null : urlFactura,
  };
}
