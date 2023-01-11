// To parse this JSON data, do
//
//     final avisoModel = avisoModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class AvisoModel {
  AvisoModel({
    this.avisoId,
    this.titulo,
    this.subtitulo,
    this.contenido,
    this.documentoAdjuntoId,
    this.fechaAviso,
  });

  int ? avisoId;
  String? titulo;
  String? subtitulo;
  String? contenido;
  int? documentoAdjuntoId;
  String? fechaAviso;

  factory AvisoModel.fromJson(String str) => AvisoModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AvisoModel.fromMap(Map<String, dynamic> json) => AvisoModel(
      avisoId: json["avisoId"] == null ? null : json["avisoId"],
    titulo: json["titulo"] == null ? null : json["titulo"],
      subtitulo: json["subtitulo"] == null ? null : json["subtitulo"],
    contenido: json["contenido"] == null ? null : json["contenido"],
      documentoAdjuntoId: json["documentoAdjuntoId"] == null ? null : json["documentoAdjuntoId"],
    fechaAviso: json["fechaAviso"] == null ? null : json["fechaAviso"]
  );

  Map<String, dynamic> toMap() => {
    "avisoId": avisoId == null ? null : avisoId,
    "titulo": titulo == null ? null : titulo,
    "subtitulo": subtitulo == null ? null : subtitulo,
    "contenido": contenido == null ? null : contenido,
    "documentoAdjuntoId": documentoAdjuntoId == null ? null : documentoAdjuntoId,
    "fechaAviso": fechaAviso == null ? null : fechaAviso,
  };
}
