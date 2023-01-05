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
    this.monto
  });

  String ? fechaFactura;
  String ? nitEmisor;
  String ? nombreComercial;
  String ? numeroFactura;
  String ? monto;

  factory DatosFacturaModel.fromJson(String str) => DatosFacturaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatosFacturaModel.fromMap(Map<String, dynamic> json) => DatosFacturaModel(
    fechaFactura: json["fechaFactura"] == null ? null : json["fechaFactura"],
    nitEmisor: json["nitEmisor"] == null ? null : json["nitEmisor"],
    nombreComercial: json["nombreComercial"] == null ? null : json["nombreComercial"],
    numeroFactura: json["numeroFactura"] == null ? null : json["numeroFactura"],
    monto: json["monto"] == null ? null : json["monto"]
  );

  Map<String, dynamic> toMap() => {
    "fechaFactura": fechaFactura == null ? null : fechaFactura,
    "nitEmisor": nitEmisor == null ? null : nitEmisor,
    "nombreComercial": nombreComercial == null ? null : nombreComercial,
    "numeroFactura": numeroFactura == null ? null : numeroFactura,
    "monto": monto == null ? null : monto
  };
}
