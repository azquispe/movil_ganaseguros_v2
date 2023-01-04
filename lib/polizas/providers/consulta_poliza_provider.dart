import 'package:movil_ganaseguros/bd/db_provider.dart';
import 'package:movil_ganaseguros/polizas/models/historial_busqueda_poliza_model.dart';
import 'package:movil_ganaseguros/polizas/models/poliza_model.dart';
import 'package:movil_ganaseguros/polizas/models/request_poliza_model.dart';
import 'package:movil_ganaseguros/polizas/services/consulta_poliza_service.dart';

import 'package:flutter/material.dart';


class ConsultaPolizaProvider with ChangeNotifier {

  TextEditingController _txtNroDocumentoController = TextEditingController();
  //TextEditingController _txtCiudadExpedidoController = TextEditingController();
  int _ciudadExpedidoId = 1007; // defecto La Paz
  TextEditingController _txtComplementoController = TextEditingController();
  TextEditingController _txtFechaNacimientoController = TextEditingController();
  List<PolizaModel> _lstPolizaModel = [];



  TextEditingController get txtNroDocumentoController =>
      _txtNroDocumentoController;

  set txtNroDocumentoController(TextEditingController value) {
    _txtNroDocumentoController = value;
  }


  int get ciudadExpedidoId => _ciudadExpedidoId;

  set ciudadExpedidoId(int value) {
    _ciudadExpedidoId = value;
  }

  List<PolizaModel> get lstPolizaModel => _lstPolizaModel;

  set lstPolizaModel(List<PolizaModel> value) {
    _lstPolizaModel = value;
  }

  TextEditingController get txtFechaNacimientoController =>
      _txtFechaNacimientoController;

  set txtFechaNacimientoController(TextEditingController value) {
    _txtFechaNacimientoController = value;
  }

  TextEditingController get txtComplementoController =>
      _txtComplementoController;

  set txtComplementoController(TextEditingController value) {
    _txtComplementoController = value;
  }




  // Creado por aquispe ............... 18/11/2022
  // Metodo que consulta poliza del servicio
  // registrar busqueda historica en caso no exista registrado
  Future<List<PolizaModel>> consultarPolizaInvitado() async {
    ConsultaPolizasService _consultaPolizaService = new ConsultaPolizasService();
    RequestPolizaModel objInsert = RequestPolizaModel(
      nroDocumento: this._txtNroDocumentoController.text,
      ciudadExpedidoId: this._ciudadExpedidoId,
      complemento: this._txtComplementoController.text,
      fechaNacimiento: this._txtFechaNacimientoController.text
    );
    this.lstPolizaModel = await  _consultaPolizaService.obtenerPolizasPorNroDocumento(objInsert);

    // Verificar
    HistorialBusquedaPolizaModel? objHistorialBusquedaPolizaModel = await DBProvider.instance.obtenerHistorialBusquedaPolizaPorNroDocumento(this._txtNroDocumentoController.text.trim());
    if(objHistorialBusquedaPolizaModel==null){
      HistorialBusquedaPolizaModel objInsert = HistorialBusquedaPolizaModel(
          nroDocumento: this._txtNroDocumentoController.text.trim(),
          ciudadExpedidoId: this.ciudadExpedidoId,
          complemento: this._txtComplementoController.text.trim(),
          nombreAsegurado:lstPolizaModel[0].nombreAsegurado, // OJO HAY Q REVISAR, DE MOMENTO ESTA AGARRANDO EL PRIMERO DE LA LISTA
          nombreTomador:lstPolizaModel[0].nombreTomador, // OJO HAY Q REVISAR, DE MOMENTO ESTA AGARRANDO EL PRIMERO DE LA LISTA
          fechaNacimiento: this.txtFechaNacimientoController.text.trim()
          );
          await DBProvider.instance.nuevoHistorialBusquedaPoliza(objInsert);
    }
    return this.lstPolizaModel;
  }
  Future<List<PolizaModel>> consultarPoliza() async {
    ConsultaPolizasService _consultaPolizaService = new ConsultaPolizasService();
    RequestPolizaModel objInsert = RequestPolizaModel(
        nroDocumento: this._txtNroDocumentoController.text,
        ciudadExpedidoId: this._ciudadExpedidoId,
        complemento: this._txtComplementoController.text,
        fechaNacimiento: this._txtFechaNacimientoController.text
    );
    this.lstPolizaModel = await  _consultaPolizaService.obtenerPolizasPorNroDocumento(objInsert);

    return this.lstPolizaModel;
  }
  limpiarCamposForm (){
    this.txtNroDocumentoController.text="";
    //this.txtExtensionController.text = "";
    this.txtComplementoController.text="";
    this.txtFechaNacimientoController.text = "";
  }
}