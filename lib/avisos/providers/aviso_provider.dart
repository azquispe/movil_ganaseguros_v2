import 'package:flutter/foundation.dart';
import 'package:movil_ganaseguros/avisos/models/aviso_model.dart';
import 'package:movil_ganaseguros/avisos/services/aviso_service.dart';

class AvisoProvider with ChangeNotifier {
  List<AvisoModel> _lstAvisoModel = [];
  bool _descargandoAviso = false;
  int _avisosNuevos = 0;


  bool get descargandoAviso => _descargandoAviso;

  set descargandoAviso(bool value) {
    _descargandoAviso = value;
    notifyListeners();
  }

  int get avisosNuevos => _avisosNuevos;

  set avisosNuevos(int value) {
    _avisosNuevos = value;
    notifyListeners();
  }

  List<AvisoModel> get lstAvisoModel => _lstAvisoModel;

  set lstAvisoModel(List<AvisoModel> value) {
    _lstAvisoModel = value;
    notifyListeners();
  }

  AvisoService _avisoService = new AvisoService();

  Future<void> obtenerAvisos() async {
    this._lstAvisoModel= [];
    this.descargandoAviso = true;
    this.lstAvisoModel = await _avisoService.obtenerAvisos();
    this.descargandoAviso = false;

  }

}
