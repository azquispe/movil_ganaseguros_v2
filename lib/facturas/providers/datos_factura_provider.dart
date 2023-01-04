import 'package:flutter/foundation.dart';
import 'package:movil_ganaseguros/facturas/models/datos_factura_model.dart';
import 'package:movil_ganaseguros/facturas/services/datos_factura_service.dart';
import 'package:movil_ganaseguros/login/services/datos_persona_service.dart';

class DatosFacturaProvider with ChangeNotifier {
  List<DatosFacturaModel> _lstDatosFacturaModel = [];

  List<DatosFacturaModel> get lstDatosFacturaModel => _lstDatosFacturaModel;

  set lstDatosFacturaModel(List<DatosFacturaModel> value) {
    _lstDatosFacturaModel = value;
  }


  Future<List<DatosFacturaModel>> consultarDatosFactura() async {
    Map<String,dynamic> pRequestDatosFacturaModel ={
      "nroDocumento": "55",
      "ciudadExpedido": "LP",
      "fechaNacimiento": "10/11/2000",
      "complemento":""
    };
    DatosFacturaService datosFacturaService = new DatosFacturaService();
    this.lstDatosFacturaModel = await  datosFacturaService.obtenerDatosFactura(pRequestDatosFacturaModel);
    return this.lstDatosFacturaModel;
  }

}