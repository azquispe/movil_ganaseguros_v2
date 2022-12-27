// To parse this JSON data, do
//
//     final datosPersonaModel = datosPersonaModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class DatosPersonaModel {
  DatosPersonaModel({
    this.personaId,
    this.generoId,
    this.nombres,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.apellidoEsposo,
    this.numeroDocumento,
    this.complemento,
    this.ciudadExpedidoId,
    this.numeroCelular,
    this.correoElectronico,
    this.fechaNacimiento,
  });

  int ? personaId;
  int ? generoId;
  String ? nombres;
  String ? apellidoPaterno;
  String ? apellidoMaterno;
  String ? apellidoEsposo;
  String ? numeroDocumento;
  String ? complemento;
  int ? ciudadExpedidoId;
  String ? numeroCelular;
  String ? correoElectronico;
  String ? fechaNacimiento;

  factory DatosPersonaModel.fromJson(String str) => DatosPersonaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DatosPersonaModel.fromMap(Map<String, dynamic> json) => DatosPersonaModel(


    personaId: json["personaId"] == null ? null : json["personaId"],
    generoId: json["generoId"] == null ? null : json["generoId"],
    nombres: json["nombres"] == null ? null : json["nombres"],
    apellidoPaterno: json["apellidoPaterno"] == null ? null : json["apellidoPaterno"],
    apellidoMaterno: json["apellidoMaterno"] == null ? null : json["apellidoMaterno"],
    apellidoEsposo: json["apellidoEsposo"]== null ? null : json["apellidoEsposo"],
    numeroDocumento: json["numeroDocumento"] == null ? null : json["numeroDocumento"],
    complemento: json["complemento"] == null ? null : json["complemento"],
    ciudadExpedidoId: json["ciudadExpedidoId"] == null ? null : json["ciudadExpedidoId"],
    numeroCelular: json["numeroCelular"] == null ? null : json["numeroCelular"],
    correoElectronico: json["correoElectronico"] == null ? null : json["correoElectronico"],
    fechaNacimiento: json["fechaNacimiento"] == null ? null : json["fechaNacimiento"],
  );

  Map<String, dynamic> toMap() => {
    "personaId": personaId == null ? null : personaId,
    "generoId": generoId == null ? null : generoId,
    "nombres": nombres == null ? null : nombres,
    "apellidoPaterno": apellidoPaterno == null ? null : apellidoPaterno,
    "apellidoMaterno": apellidoMaterno == null ? null : apellidoMaterno,
    "apellidoEsposo": apellidoEsposo == null ? null : apellidoEsposo,
    "numeroDocumento": numeroDocumento == null ? null : numeroDocumento,
    "complemento": complemento == null ? null : complemento,
    "ciudadExpedidoId": ciudadExpedidoId == null ? null : ciudadExpedidoId,
    "numeroCelular": numeroCelular == null ? null : numeroCelular,
    "correoElectronico": correoElectronico == null ? null : correoElectronico,
    "fechaNacimiento": fechaNacimiento == null ? null : fechaNacimiento,
  };
}
