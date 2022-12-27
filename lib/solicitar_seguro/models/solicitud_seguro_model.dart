// To parse this JSON data, do
//
//     final solicitudSeguroModel = solicitudSeguroModelFromMap(jsonString);


import 'dart:convert';

class SolicitudSeguroModel {
  SolicitudSeguroModel({
    required this.nombres,
    required this.apellidos,
    required this.telefonoCelular,
    required this.correo,
    required this.ciudadId,
    required this.tipoProductoId,
    required this.tieneSeguroNosotros,
    required this.tieneSeguroOtros,
    required this.descripcion
  });

  String nombres;
  String apellidos;
  String telefonoCelular;
  String correo;
  int ciudadId;
  bool tieneSeguroNosotros;
  bool tieneSeguroOtros;
  int tipoProductoId;
  String descripcion;



  factory SolicitudSeguroModel.fromJson(String str) => SolicitudSeguroModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SolicitudSeguroModel.fromMap(Map<String, dynamic> json) => SolicitudSeguroModel(
    nombres: json["nombres"] == null ? null : json["nombres"],
    apellidos: json["apellidos"] == null ? null : json["apellidos"],
    telefonoCelular: json["telefonoCelular"] == null ? null : json["telefonoCelular"],
    correo: json["correo"] == null ? null : json["correo"],
    ciudadId: json["ciudadId"] == null ? null : json["ciudadId"],
    tieneSeguroNosotros: json["tieneSeguroNosotros"] == null ? null : json["tieneSeguroNosotros"],
    tieneSeguroOtros: json["tieneSeguroOtros"] == null ? null : json["tieneSeguroOtros"],
    tipoProductoId: json["tipoProductoId"] == null ? null : json["tipoProductoId"],
    descripcion: json["descripcion"] == null ? null : json["descripcion"],
  );

  Map<String, dynamic> toMap() => {
    "nombres": nombres == null ? null : nombres,
    "apellidos": apellidos == null ? null : apellidos,
    "telefonoCelular": telefonoCelular == null ? null : telefonoCelular,
    "correo": correo == null ? null : correo,
    "ciudadId": ciudadId == null ? null : ciudadId,
    "tieneSeguroNosotros": tieneSeguroNosotros == null ? null : tieneSeguroNosotros,
    "tieneSeguroOtros": tieneSeguroOtros == null ? null : tieneSeguroOtros,
    "tipoProductoId": tipoProductoId == null ? null : tipoProductoId,
    "descripcion": descripcion == null ? null : descripcion,
  };
}

