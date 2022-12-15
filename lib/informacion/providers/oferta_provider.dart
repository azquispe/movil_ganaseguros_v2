import 'package:flutter/foundation.dart';
import 'package:movil_ganaseguros/informacion/models/oferta_model.dart';
import 'package:movil_ganaseguros/informacion/services/oferta_service.dart';

class OfertaProvider with ChangeNotifier {
  List<OfertaModel> _lstOfertaModel = [];
  bool _descargandoOferta = false;


  bool get descargandoOferta => _descargandoOferta;

  set descargandoOferta(bool value) {
    _descargandoOferta = value;
    notifyListeners();
  }

  List<OfertaModel> get lstOfertaModel => _lstOfertaModel;

  set lstOfertaModel(List<OfertaModel> value) {
    _lstOfertaModel = value;
    notifyListeners();
  }

  OfertaService _ofertaService = new OfertaService();

  Future<void> obtenerOfertas() async {
    this._lstOfertaModel= [];
    this.descargandoOferta = true;
    this.lstOfertaModel = await _ofertaService.obtenerOfertas();
    this.descargandoOferta = false;
  }

}
