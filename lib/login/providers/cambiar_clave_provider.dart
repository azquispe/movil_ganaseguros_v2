import 'package:flutter/cupertino.dart';
import 'package:movil_ganaseguros/bd/db_provider.dart';
import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:movil_ganaseguros/login/services/cambiar_clave_service.dart';

class CambiarClaveProvider with ChangeNotifier{
  TextEditingController _txtClaveNuevaController = TextEditingController();
  TextEditingController _txtClaveAnteriorController = TextEditingController();
  TextEditingController _txtClaveNuevaRepetidoController = TextEditingController();


  TextEditingController get txtClaveNuevaController => _txtClaveNuevaController;

  set txtClaveNuevaController(TextEditingController value) {
    _txtClaveNuevaController = value;
  }

  TextEditingController get txtClaveAnteriorController =>
      _txtClaveAnteriorController;


  TextEditingController get txtClaveNuevaRepetidoController =>
      _txtClaveNuevaRepetidoController;

  set txtClaveNuevaRepetidoController(TextEditingController value) {
    _txtClaveNuevaRepetidoController = value;
  }

  set txtClaveAnteriorController(TextEditingController value) {
    _txtClaveAnteriorController = value;
  }

  Future<Map<String,dynamic>> cambiarClave() async {
    if(txtClaveNuevaController.text.trim()=="" || txtClaveAnteriorController.text.trim()=="" || txtClaveNuevaRepetidoController.text.trim()==""){
      return {
        "procesoCompletado":false,
        "mensaje":"Debe llenar todos los datos"
      };
    }
    if(txtClaveNuevaController.text.trim()!=txtClaveNuevaRepetidoController.text.trim()){
      return {
        "procesoCompletado":false,
        "mensaje":"Las claves no son Iguales"
      };
    }

    DatosPersonaModel objPersonaSqlite  =  await DBProvider.instance.obtenerDatosPersona();
    if(objPersonaSqlite.personaId==null){
      return {
        "procesoCompletado":false,
        "mensaje":"Los datos de la persona no existe, debe inciar sessión nuevamente"
      };
    }

    CambiarClaveService cambiarClaveService = new CambiarClaveService();
    bool res = await   cambiarClaveService.cambiarClave(objPersonaSqlite.personaId!, txtClaveAnteriorController.value.text,txtClaveNuevaController.value.text);
    return {
      "procesoCompletado":res,
      "mensaje":res?"Actualización de clave correcto, debe iniciar sessión":"Algo salio mal, comuniquese con administrador"
    };

  }

}