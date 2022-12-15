// To parse this JSON data, do
//
//     final avisoModel = avisoModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AvisoModel {
  AvisoModel({
    this.avisoId,
    this.titulo,
    this.contenido,
    this.enlace,
    this.fechaAviso,
  });

  int ? avisoId;
  String? titulo;
  String? contenido;
  String? enlace;
  String? fechaAviso;

  factory AvisoModel.fromJson(String str) => AvisoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AvisoModel.fromMap(Map<String, dynamic> json) => AvisoModel(
      avisoId: json["avisoId"] == null ? null : json["avisoId"],
    titulo: json["titulo"] == null ? null : json["titulo"],
    contenido: json["contenido"] == null ? null : json["contenido"],
    enlace: json["enlace"] == null ? null : json["enlace"],
    fechaAviso: json["fechaAviso"] == null ? null : json["fechaAviso"]
  );

  Map<String, dynamic> toMap() => {
    "avisoId": avisoId == null ? null : avisoId,
    "titulo": titulo == null ? null : titulo,
    "contenido": contenido == null ? null : contenido,
    "enlace": enlace == null ? null : enlace,
    "fechaAviso": fechaAviso == null ? null : fechaAviso,
  };
}
