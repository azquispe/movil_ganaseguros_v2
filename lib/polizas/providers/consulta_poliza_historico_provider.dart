import 'package:movil_ganaseguros/bd/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/polizas/models/historial_busqueda_poliza_model.dart';


class ConsultaPolizaHistoricoProvider with ChangeNotifier {

  // GET AND SET
  List<HistorialBusquedaPolizaModel> _historialBusquedaPolizaModel = [];
  List<HistorialBusquedaPolizaModel> get lstDatosPersonasModel => this._historialBusquedaPolizaModel;
  set lstHistorialBusquedaPoliza(List<HistorialBusquedaPolizaModel> lstDatosPersonas) {
    this._historialBusquedaPolizaModel = lstDatosPersonas;
    notifyListeners();
  }
  // ===========================

  Future<List<HistorialBusquedaPolizaModel>> obtenerTodosHistorialBusquedaPoliza() async {
    lstHistorialBusquedaPoliza =  await DBProvider.instance.obtenerTodosHistorialBusquedaPoliza();
    return lstDatosPersonasModel;
  }
  Future<void> eliminarHistorialBusquedaPoliza(BuildContext context, pDatosPersonaId) async {
    await DBProvider.instance.eliminarHistorialBusquedaPoliza(pDatosPersonaId);
    await this.obtenerTodosHistorialBusquedaPoliza();
  }

}
