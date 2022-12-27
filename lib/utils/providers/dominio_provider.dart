import 'package:flutter/foundation.dart';
import 'package:movil_ganaseguros/solicitar_seguro/services/dominio_service.dart';
import 'package:movil_ganaseguros/utils/models/dominio_model.dart';

class DominioProvider  with ChangeNotifier {
  List<DominioModel>  _lstCiudad = [];
  List<DominioModel>  _lstTipoProducto = [];
  List<DominioModel>  _lstCiudadExpedido = [];
  List<DominioModel>  _lstGenero = [];

  List<DominioModel> get lstCiudad => _lstCiudad;

  set lstCiudad(List<DominioModel> value) {
    _lstCiudad = value;
    notifyListeners();
  }
  List<DominioModel> get lstTipoProducto => _lstTipoProducto;

  set lstTipoProducto(List<DominioModel> value) {
    _lstTipoProducto = value;
    notifyListeners();
  }

  List<DominioModel> get lstCiudadExpedido => _lstCiudadExpedido;

  set lstCiudadExpedido(List<DominioModel> value) {
    _lstCiudadExpedido = value;
    notifyListeners();
  }

  List<DominioModel> get lstGenero => _lstGenero;

  set lstGenero(List<DominioModel> value) {
    _lstGenero = value;
    notifyListeners();
  }

  DominioService dominioService = new DominioService();
  Future<void> obtenerCiudadDominio() async {
    _lstCiudad=[];
    lstCiudad = await dominioService.obtenerDominioPorDominio("CiudadID");
    print("==== DESCARGAR DOMINIO CIUDAD =====");
  }
  Future<void> obtenerTipoProductoDominio() async {
    _lstTipoProducto=[];
    lstTipoProducto = await dominioService.obtenerDominioPorDominio("TipoProductoID");
    print("==== DESCARGAR DOMINIO TIPO DE PRODUCTO =====");
  }
  Future<void> obtenerCiudadExpedido() async {
    _lstCiudadExpedido=[];
    lstCiudadExpedido = await dominioService.obtenerDominioPorDominio("CiudadExpedidoID");
    print("==== DESCARGAR DOMINIO CIUDAD EXPEDIDO =====");
  }
  Future<void> obtenerGenero() async {
    _lstGenero=[];
    lstGenero = await dominioService.obtenerDominioPorDominio("GeneroID");
    print("==== DESCARGAR DOMINIO GENEROO =====");
  }


}