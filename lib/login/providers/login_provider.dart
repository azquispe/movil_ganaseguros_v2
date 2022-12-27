

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/bd/db_provider.dart';
import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:movil_ganaseguros/login/services/login_service.dart';

class LoginProvider with ChangeNotifier {

  // para login
  TextEditingController _txtUsuarioController = TextEditingController();
  TextEditingController _txtPasswordController = TextEditingController();
  // ===






  TextEditingController get txtUsuarioController => _txtUsuarioController;

  set txtUsuarioController(TextEditingController value) {
    _txtUsuarioController = value;
  }
  TextEditingController get txtPasswordController => _txtPasswordController;

  set txtPasswordController(TextEditingController value) {
    _txtPasswordController = value;
  }

  DatosPersonaModel _datosPersonaModel = new DatosPersonaModel();
  DatosPersonaModel get datosPersonaModel => _datosPersonaModel;

  set datosPersonaModel(DatosPersonaModel value) {
    _datosPersonaModel = value;
    notifyListeners();
  }



  Future<bool> login()  async {
    this._datosPersonaModel= new DatosPersonaModel();
    LoginService loginService = new LoginService();
    this.datosPersonaModel = await loginService.login(_txtUsuarioController.text, _txtPasswordController.text);
    if(this.datosPersonaModel.personaId!=null){
      await DBProvider.instance.eliminarDatosPersonaTodos();
      await DBProvider.instance.nuevoPersona(this.datosPersonaModel);
      return true;
    }else{
      return false;
    }
  }
  Future<void> obtenerDatosPersona() async {
    this.datosPersonaModel =  await DBProvider.instance.obtenerDatosPersona();
  }
  Future<void>eliminarDatosPersonaTodos () async{
    await DBProvider.instance.eliminarDatosPersonaTodos();
    this.datosPersonaModel= new DatosPersonaModel();
  }

}