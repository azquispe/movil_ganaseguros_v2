import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:movil_ganaseguros/facturas/models/datos_factura_model.dart';
import 'package:movil_ganaseguros/facturas/providers/datos_factura_provider.dart';
import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:movil_ganaseguros/login/providers/login_provider.dart';
import 'package:movil_ganaseguros/polizas/models/poliza_model.dart';
import 'package:movil_ganaseguros/polizas/providers/consulta_poliza_provider.dart';
import 'package:movil_ganaseguros/utils/dialogos.dart';
import 'package:movil_ganaseguros/utils/estilos.dart';
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';


class CardInicioWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Table(
      children:  [
        TableRow(children: [
          _SingleCard(
              pathImg: "assets/img/ganaSeguros_banner1.jpg",
              color: colores.sec_negro_claro1,
              text: loginProvider.datosPersonaModel.personaId!=null?'Mis pólizas': 'Consultar Póliza',
              pageName: 'consulta_poliza_historico_page'),
          loginProvider.datosPersonaModel.personaId!=null? _SingleCard(
                pathImg: "assets/icon/icon_facturas.jpg",
                color: colores.sec_negro_claro1,
                text: 'Mis facturas',
                pageName: 'lista_facturas_page'):Container(),

          _SingleCard(
              pathImg: "assets/img/ganaSeguros_banner2.jpg",
              color: colores.sec_negro_claro1,
              text: 'Solicitar Seguro',
              pageName: 'solicitar_seguro_page'),

        ]),

      ],
    );
  }
}

class _SingleCard extends StatelessWidget {

  final String pathImg;
  final Color color;
  final String text;
  final String pageName;

  const _SingleCard(
      {required this.pathImg,
      required this.color,
      required this.text,
      required this.pageName});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final consultaPolizaProvider = Provider.of<ConsultaPolizaProvider>(context,listen: false);
    final datosFacturaProvider = Provider.of<DatosFacturaProvider>(context,listen: false);
    DatosPersonaModel datosPersonaModel = loginProvider.datosPersonaModel;
    return GestureDetector (

        onTap: () async {
          if((datosPersonaModel.personaId!=null && datosPersonaModel.personaId!>0) && this.pageName=="consulta_poliza_historico_page")
          {

            consultaPolizaProvider.txtNroDocumentoController.text = datosPersonaModel.numeroDocumento.toString();
            consultaPolizaProvider.ciudadExpedidoId = datosPersonaModel.ciudadExpedidoId!;
            consultaPolizaProvider.txtComplementoController.text = datosPersonaModel.complemento.toString();
            consultaPolizaProvider.txtFechaNacimientoController.text = datosPersonaModel.fechaNacimiento.toString();

            List<PolizaModel> ? lstPolizaModel = await showDialog(
              context: context,
              builder: (context) =>
                  FutureProgressDialog(consultaPolizaProvider.consultarPoliza() ,
                      message: Text(
                        'Procesando...',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: colores.sec_negro_claro2,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
            );
            if (lstPolizaModel!=null && lstPolizaModel.length > 0) {
              Navigator.of(context).pushNamed('lista_poliza_detalle_page');
            } else {
              Dialogos.dialogoInformativo(pTitulo: "Consulta de Póliza",pDescripcion: "No se ha encontrado Póliza \n Si desea consultar Póliza para otro asegurado ingrese como INVITADO  o creando una nueva CUENTA",pContext: context,pBoton: "Aceptar",pTipoAlerta: AlertType.info).show();
            }
          }
          else if((datosPersonaModel.personaId!=null && datosPersonaModel.personaId!>0) && this.pageName=="lista_facturas_page"){
            List<DatosFacturaModel> ? lstDatosfacturaModel = await showDialog(
              context: context,
              builder: (context) =>
                  FutureProgressDialog(datosFacturaProvider.consultarDatosFactura() ,
                      message: Text(
                        'Procesando...',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: colores.sec_negro_claro2,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
            );
            if (lstDatosfacturaModel!=null && lstDatosfacturaModel.length > 0) {
              Navigator.of(context).pushNamed('lista_facturas_page');
            } else {
              Dialogos.dialogoInformativo(pTitulo: "Consulta de Facturas",pDescripcion: "No cuenta con facturas",pContext: context,pBoton: "Aceptar",pTipoAlerta: AlertType.info).show();
            }
          }
          else{
            Navigator.of(context).pushNamed(this.pageName);
          }



        },

    child: Card(
      elevation:0,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: colores.sec_verde_oscuro,
        ),
        borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(this.pathImg,width: 110),
            const SizedBox(height: 10,),
            Text( text,
              //style: Estilos.stlTextoContenido(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,)
          ],
        ),
      ),
    ));
  }
  Future<void> _launchUrl(pUrl) async {
    if (!await launchUrl( Uri.parse(pUrl))) {
      throw 'Could not launch $pUrl';
    }
  }
}
