// To parse this JSON data, do
//
//     final avisoModel = avisoModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class OfertaModel {
  OfertaModel({
    this.ofertaSliderId,
    this.titulo,
    this.subtitulo,
    this.contenido,
    this.aplicacionId,
    this.documentoAdjuntoId
  });



  int ? ofertaSliderId;
  String? titulo;
  String? subtitulo;
  String? contenido;
  int? aplicacionId;
  int? documentoAdjuntoId;

  factory OfertaModel.fromJson(String str) => OfertaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfertaModel.fromMap(Map<String, dynamic> json) => OfertaModel(
      ofertaSliderId: json["ofertaSliderId"] == null ? null : json["ofertaSliderId"],
    titulo: json["titulo"] == null ? null : json["titulo"],
      subtitulo: json["subtitulo"] == null ? null : json["subtitulo"],
    contenido: json["contenido"] == null ? null : json["contenido"],
      documentoAdjuntoId: json["documentoAdjuntoId"] == null ? null : json["documentoAdjuntoId"]
  );

  Map<String, dynamic> toMap() => {
    "ofertaSliderId": ofertaSliderId == null ? null : ofertaSliderId,
    "titulo": titulo == null ? null : titulo,
    "subtitulo": subtitulo == null ? null : subtitulo,
    "contenido": contenido == null ? null : contenido,
    "documentoAdjuntoId": documentoAdjuntoId == null ? null : documentoAdjuntoId
  };
}
