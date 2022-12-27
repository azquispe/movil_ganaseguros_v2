import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/bd/db_provider.dart';
import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:movil_ganaseguros/login/services/datos_persona_service.dart';

class DatosUsuarioProvider with ChangeNotifier{
  // para formulario
  TextEditingController _txtNombresController = TextEditingController();
  TextEditingController _txtPaternoController = TextEditingController();
  TextEditingController _txtMaternoController = TextEditingController();
  TextEditingController _txtNroDocumentoController = TextEditingController();
  int _ciudadExpedidoId = 1007; // defecto La Paz
  TextEditingController _txtComplementoController = TextEditingController();
  TextEditingController _txtCelularController = TextEditingController();
  TextEditingController _txtCorreoController = TextEditingController();
  TextEditingController _txtFechaNacimientoController = TextEditingController();
   // ===

  TextEditingController get txtNombresController => _txtNombresController;

  set txtNombresController(TextEditingController value) {
    _txtNombresController = value;
    notifyListeners();
  }

  TextEditingController get txtPaternoController => _txtPaternoController;

  set txtPaternoController(TextEditingController value) {
    _txtPaternoController = value;
    notifyListeners();
  }

  TextEditingController get txtMaternoController => _txtMaternoController;

  set txtMaternoController(TextEditingController value) {
    _txtMaternoController = value;
    notifyListeners();
  }

  TextEditingController get txtNroDocumentoController =>
      _txtNroDocumentoController;

  set txtNroDocumentoController(TextEditingController value) {
    _txtNroDocumentoController = value;
    notifyListeners();
  }


  int get ciudadExpedidoId => _ciudadExpedidoId;

  set ciudadExpedidoId(int value) {
    _ciudadExpedidoId = value;
    notifyListeners();
  }

  TextEditingController get txtComplementoController =>
      _txtComplementoController;

  set txtComplementoController(TextEditingController value) {
    _txtComplementoController = value;
    notifyListeners();
  }

  TextEditingController get txtCelularController => _txtCelularController;

  set txtCelularController(TextEditingController value) {
    _txtCelularController = value;
    notifyListeners();
  }

  TextEditingController get txtCorreoController => _txtCorreoController;

  set txtCorreoController(TextEditingController value) {
    _txtCorreoController = value;
    notifyListeners();
  }

  TextEditingController get txtFechaNacimientoController =>
      _txtFechaNacimientoController;

  set txtFechaNacimientoController(TextEditingController value) {
    _txtFechaNacimientoController = value;
    notifyListeners();
  }


  Future<void> obtenerDatosPersonaAformulario() async {
    DatosPersonaModel obj  =  await DBProvider.instance.obtenerDatosPersona();
    txtNombresController.text = (obj.nombres!=null)?obj.nombres!:"";
    txtPaternoController.text = (obj.apellidoPaterno!=null)?obj.apellidoPaterno!:"";
    txtMaternoController.text = (obj.apellidoMaterno!=null)?obj.apellidoMaterno!:"";
    txtNroDocumentoController.text = (obj.numeroDocumento!=null)?obj.numeroDocumento!:"";
    ciudadExpedidoId = obj.ciudadExpedidoId!;
    txtComplementoController.text = (obj.complemento!=null)?obj.complemento!:"";
    txtCelularController.text = (obj.numeroCelular!=null)?obj.numeroCelular!:"";
    txtCorreoController.text = (obj.correoElectronico!=null)?obj.correoElectronico!:"";
    txtFechaNacimientoController.text = (obj.fechaNacimiento!=null)?obj.fechaNacimiento!:"";
  }
  Future<bool> actualizarPersonaServer() async {
    DatosPersonaModel objPersonaSqlite  =  await DBProvider.instance.obtenerDatosPersona();
    DatosPersonaModel objUpdate = new DatosPersonaModel();
    objUpdate.personaId = objPersonaSqlite.personaId;
    objUpdate.generoId = 1025; // aun esta quemado
    objUpdate.nombres = txtNombresController.text;
    objUpdate.apellidoPaterno = txtPaternoController.text;
    objUpdate.apellidoMaterno = txtMaternoController.text;
    objUpdate.numeroDocumento = txtNroDocumentoController.text;
    objUpdate.ciudadExpedidoId = ciudadExpedidoId;
    objUpdate.complemento = txtComplementoController.text;
    objUpdate.numeroCelular = txtCelularController.text;
    objUpdate.correoElectronico = txtCorreoController.text;
    objUpdate.fechaNacimiento = txtFechaNacimientoController.text;
    DatosPersonaService datosPersonaService = new DatosPersonaService();
    return datosPersonaService.actualizarPersona(objUpdate);
  }
  Future<bool> actualizarPersonaLocal()  async {
    DatosPersonaService datosPersonaService = new DatosPersonaService();
    DatosPersonaModel objPersonaSqlite  =  await DBProvider.instance.obtenerDatosPersona();
    DatosPersonaModel datosPersonaModel =  await datosPersonaService.obtenerPersona( objPersonaSqlite.personaId!);
    if(datosPersonaModel.personaId!=null){
      await DBProvider.instance.eliminarDatosPersonaTodos();
      await DBProvider.instance.nuevoPersona(datosPersonaModel);
      return true;
    }else{
      return false;
    }
  }
  Future<bool> actualizarPersona() async {
    bool re1 =  await this.actualizarPersonaServer();
    bool re2 = await this.actualizarPersonaLocal();
    if(re1 && re2){
      return true;
    }else{
      return false;
    }
  }

}



