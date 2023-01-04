import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/informacion/widgets/custom_bottom_navigator_widget.dart';
import 'package:movil_ganaseguros/polizas/models/historial_busqueda_poliza_model.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:movil_ganaseguros/utils/constantes.dart' as constantes;
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil_ganaseguros/utils/dialogos.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/poliza_model.dart';

import '../providers/consulta_poliza_historico_provider.dart';
import '../providers/consulta_poliza_provider.dart';



class ConsultaPolizaHistoricoPage extends StatefulWidget {
  @override
  State<ConsultaPolizaHistoricoPage> createState() => _ConsultaPolizaHistoricoPageState();
}

class _ConsultaPolizaHistoricoPageState extends State<ConsultaPolizaHistoricoPage> {
  @override
  void initState() {
    // TODO: implement initState
    //obtieneHistorialBusqueda(context);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<ConsultaPolizaHistoricoProvider>(context,listen: false).obtenerTodosHistorialBusquedaPoliza();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final consultaPolizaHistoricoProvider = Provider.of<ConsultaPolizaHistoricoProvider>(context);
    return Scaffold(
      backgroundColor: colores.pri_blanco,
      appBar: AppBar(
        title: const Image(
            width: 200,
            height: 50,
            image: AssetImage('assets/img/logo_ganaseguros_400.png')),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: colores.pri_verde_claro),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  // fromHeight use double.infinity as width and 40 is the height
                  elevation: 0,
                  backgroundColor: colores.sec_verde_claro,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () async {
                  Navigator.of(context).pushNamed('consulta_poliza_page');
                },
                child: Text(
                  'Nueva Búsqueda',
                  style: TextStyle(
                      color: colores.pri_blanco,
                      fontFamily: constantes.tipo_fuente_poppins,
                      fontSize: 17),
                ),
              ),
            ),
            Text('Historial de Búsquedas',
                textAlign: TextAlign.center,
                //style: Estilos.stlTextoSubTitulo(themeProvider.ColorSubTitulo)
                style: Theme.of(context).textTheme.subtitle1),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: consultaPolizaHistoricoProvider
                      .lstDatosPersonasModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _crearItemDatosPersona(
                        pHistorialBusquedaPolizaModel: consultaPolizaHistoricoProvider
                            .lstDatosPersonasModel[index],
                        context: context);
                  }),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigatorWidget(),
    );
  }

  Widget _crearItemDatosPersona(
      {required HistorialBusquedaPolizaModel pHistorialBusquedaPolizaModel,
      required BuildContext context}) {
    final consultaPolizaHistoricoProvider = Provider.of<ConsultaPolizaHistoricoProvider>(context, listen: false);
    final consultaPolizaProvider = Provider.of<ConsultaPolizaProvider>(context);
    return Card(
        color: colores.pri_blanco,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: colores.sec_verde_oscuro,
          ),
          borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
        ),
        elevation: 0,
        child: Container(
            //padding: EdgeInsets.all(10),
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            pHistorialBusquedaPolizaModel.nombreAsegurado.toString() +
                                "\n " +
                                pHistorialBusquedaPolizaModel.nroDocumento.toString(),
                            //style: Estilos.stlTextoContenido(themeProvider.ColorContenido),
                            style: Theme.of(context).textTheme.bodyText1,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ],
                  ), //BoxDecoration
                ), //Container
                const SizedBox(
                  width: 10,
                ), //SizedBox
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colores.sec_verde_claro2,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () async {

                          consultaPolizaProvider.txtNroDocumentoController.text = pHistorialBusquedaPolizaModel.nroDocumento.toString();
                          consultaPolizaProvider.ciudadExpedidoId = pHistorialBusquedaPolizaModel.ciudadExpedidoId!;
                          consultaPolizaProvider.txtComplementoController.text = pHistorialBusquedaPolizaModel.complemento.toString();
                          consultaPolizaProvider.txtFechaNacimientoController.text = pHistorialBusquedaPolizaModel.fechaNacimiento.toString();

                          List<PolizaModel> ? lstPolizaModel = await showDialog(
                            context: context,
                            builder: (context) =>
                                FutureProgressDialog(consultaPolizaProvider.consultarPolizaInvitado() ,
                                    message: Text(
                                      'Procesando...',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: colores.sec_negro_claro2,
                                            letterSpacing: 0.3,
                                            //fontSize: 22,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    )),
                          );
                          //List<PolizaModel>? lstPolizaModel = await consultarPoliza(context);
                          if (lstPolizaModel!=null && lstPolizaModel.length > 0) {
                            Navigator.of(context).pushNamed('lista_poliza_detalle_page');
                          } else {

                            Dialogos.dialogoInformativo(pTitulo: "Consulta de Póliza",pDescripcion: "No se ha encontrado Póliza",pContext: context,pBoton: "Aceptar",pTipoAlerta: AlertType.success).show();

                          }
                        },
                        child: Text(
                          'Consultar Póliza',
                          style: TextStyle(
                              color: colores.sec_verde_claro,
                              fontFamily: constantes.tipo_fuente_poppins,
                              fontSize: 12),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.clear_outlined,
                          color: colores.sec_rosa,
                        ),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => FutureProgressDialog(
                                consultaPolizaHistoricoProvider
                                    .eliminarHistorialBusquedaPoliza(context,
                                    pHistorialBusquedaPolizaModel.historialBusquedaPolizaId!),
                                message: Text(
                                  'Procesando...',
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: colores.sec_negro_claro2,
                                        letterSpacing: 0.3,
                                        //fontSize: 22,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )),
                          );


                          Dialogos.dialogoInformativo(pTitulo: "",pDescripcion: "Registro Eliminado",pContext: context,pBoton: "Aceptar",pTipoAlerta: AlertType.info).show();

                        },
                      ),
                    ],
                  ),
                  //BoxDecoration
                ) //Container
              ],
            ),
          ],
        )));
  }
  /*obtieneHistorialBusqueda (BuildContext context)async{
    final consultaPolizaHistoricoProvider = Provider.of<ConsultaPolizaHistoricoProvider>(context,listen: false);
    await consultaPolizaHistoricoProvider.obtenerTodosHistorialBusquedaPoliza();
  }*/
}
