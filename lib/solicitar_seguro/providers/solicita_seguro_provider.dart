import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/solicitar_seguro/services/solicita_seguro_service.dart';
import '../models/solicitud_seguro_model.dart';

class SolicitaSeguroProvider with ChangeNotifier{
  TextEditingController  _txtNombreController = TextEditingController();
  TextEditingController _txtApellidoController = TextEditingController();
  TextEditingController _txtTelCelController = TextEditingController();
  TextEditingController _txtCorreoController = TextEditingController();
  int _ciudadId = 1016; // defecto La Paz
  bool _boolTieneSeguroNosotros = false;
  bool _boolTieneSeguroOtros = false;
  int _tipoProductoId = 1004; // defecto desgravamen
  TextEditingController _txtDescripcionController = TextEditingController();


  TextEditingController get txtNombreController => _txtNombreController;

  set txtNombreController(TextEditingController value) {
    _txtNombreController = value;
  }
  TextEditingController get txtApellidoController => _txtApellidoController;

  set txtApellidoController(TextEditingController value) {
    _txtApellidoController = value;
  }

  TextEditingController get txtTelCelController => _txtTelCelController;

  set txtTelCelController(TextEditingController value) {
    _txtTelCelController = value;
  }

  TextEditingController get txtCorreoController => _txtCorreoController;

  set txtCorreoController(TextEditingController value) {
    _txtCorreoController = value;
  }


  int get ciudadId => _ciudadId;

  set ciudadId(int value) {
    _ciudadId = value;
    notifyListeners();
  }

  int get tipoProductoId => _tipoProductoId;

  set tipoProductoId(int value) {
    _tipoProductoId = value;
    notifyListeners();
  }


  bool get boolTieneSeguroNosotros => _boolTieneSeguroNosotros;

  set boolTieneSeguroNosotros(bool value) {
    _boolTieneSeguroNosotros = value;
    notifyListeners();
  }

  TextEditingController get txtDescripcionController =>
      _txtDescripcionController;

  set txtDescripcionController(TextEditingController value) {
    _txtDescripcionController = value;
  }

  Future<bool> enviarSolicitudSeguro() async {
    SolicitudSeguroModel objSolicitudSeguroModel = new SolicitudSeguroModel(
        nombres: _txtNombreController.text,
        apellidos: _txtApellidoController.text,
        telefonoCelular: _txtTelCelController.text,
        correo: _txtCorreoController.text,
        ciudadId: _ciudadId,
        tieneSeguroNosotros: _boolTieneSeguroNosotros,
        tieneSeguroOtros:_boolTieneSeguroOtros,
        tipoProductoId:tipoProductoId,
        descripcion: _txtDescripcionController.text
    );
    SolicitaSeguroService _solicitaSeguroService = new SolicitaSeguroService();
    return await _solicitaSeguroService.enviarSolicitudSeguro(objSolicitudSeguroModel);
  }

  bool get boolTieneSeguroOtros => _boolTieneSeguroOtros;

  set boolTieneSeguroOtros(bool value) {
    _boolTieneSeguroOtros = value;
    notifyListeners();
  }
}