// To parse this JSON data, do
//
//     final avisoModel = avisoModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class OfertaModel {
  OfertaModel({
    this.ofertaSliderId,
    this.titulo,
    this.contenido,
    this.enlace
  });



  int ? ofertaSliderId;
  String? titulo;
  String? contenido;
  String? enlace;

  factory OfertaModel.fromJson(String str) => OfertaModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfertaModel.fromMap(Map<String, dynamic> json) => OfertaModel(
      ofertaSliderId: json["ofertaSliderId"] == null ? null : json["ofertaSliderId"],
    titulo: json["titulo"] == null ? null : json["titulo"],
    contenido: json["contenido"] == null ? null : json["contenido"],
    enlace: json["enlace"] == null ? null : json["enlace"]
  );

  Map<String, dynamic> toMap() => {
    "ofertaSliderId": ofertaSliderId == null ? null : ofertaSliderId,
    "titulo": titulo == null ? null : titulo,
    "contenido": contenido == null ? null : contenido,
    "enlace": enlace == null ? null : enlace
  };
}
