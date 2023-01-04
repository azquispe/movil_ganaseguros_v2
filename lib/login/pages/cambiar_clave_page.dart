import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:movil_ganaseguros/login/providers/cambiar_clave_provider.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:movil_ganaseguros/utils/constantes.dart' as constantes;
import 'package:movil_ganaseguros/utils/dialogos.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CambiarClavePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colores.pri_blanco,
      appBar: AppBar(
        title: Image(
            width: 200,
            height: 50,
            image: AssetImage('assets/img/logo_ganaseguros_400.png')),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colores.pri_verde_claro),
        elevation: 0,
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
        Text(
          textAlign: TextAlign.center,
          'Cambia tu contraseña',
          //style: Estilos.stlTextoTitulo(),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(
          height: 10,
        ),
        Card(
            elevation: 0,
            child: Container(
                padding: EdgeInsets.all(10), child: Column(children: [

                Text(
                  textAlign: TextAlign.center,
                  'Es recomendable que tu contraseña deba contener caracteres como Mayúsculas, Minúsculas, Números y 8 o mas caracteres',
                  style:  Theme.of(context).textTheme.bodyText1,),
              SizedBox(
                height: 30,
              ),
              _crearClaveAnterior(context),
              SizedBox(
                height: 10,
              ),
              _crearClaveNueva(context),
              SizedBox(
                height: 10,
              ),
              _crearClaveNuevaRepetido(context),
              SizedBox(
                height: 30,
              ),
              _crearBtnCambiarClave(context)
            ])))
      ]),
    );
  }
  Widget _crearClaveAnterior(BuildContext context) {
    final cambiarClaveProvider = Provider.of<CambiarClaveProvider>(context);
    return TextFormField(
      obscureText: true,
      controller: cambiarClaveProvider.txtClaveAnteriorController,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: 'Contraseña  actual',
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: colores.pri_verde_claro, width: 2))),
    );
  }
  Widget _crearClaveNueva(BuildContext context) {
    final cambiarClaveProvider = Provider.of<CambiarClaveProvider>(context);
    return TextFormField(
      obscureText: true,
      controller: cambiarClaveProvider.txtClaveNuevaController,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: 'Nueva contraseña',
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: colores.pri_verde_claro, width: 2))),
    );
  }
  Widget _crearClaveNuevaRepetido(BuildContext context) {
    final cambiarClaveProvider = Provider.of<CambiarClaveProvider>(context);
    return TextFormField(
      obscureText: true,
      controller: cambiarClaveProvider.txtClaveNuevaRepetidoController,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: 'Repetir nueva contraseña',
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: colores.pri_verde_claro, width: 2))),
    );
  }
  Widget _crearBtnCambiarClave(BuildContext context) {
    final cambiarClaveProvider = Provider.of<CambiarClaveProvider>(context, listen: false);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          elevation: 0,
          backgroundColor: colores.sec_verde_claro,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () async {
          Map<String,dynamic> res = await showDialog(
            context: context,
            builder: (context) => FutureProgressDialog(
                cambiarClaveProvider.cambiarClave(),
                message: Text('Procesando...')),
          );
          if (res['procesoCompletado']==true) {
            Dialogos.dialogoInformativo(
                pTitulo: "Registro de Usuario",
                pDescripcion:
                res['mensaje'],
                pContext: context,
                pBoton: "Aceptar",
                pTipoAlerta: AlertType.success,pPathRedirect: "login_page")
                .show();

          } else {
            Dialogos.dialogoInformativo(
                pTitulo: "Registro de Usuario",
                pDescripcion: res['mensaje'],
                pContext: context,
                pBoton: "Aceptar",
                pTipoAlerta: AlertType.error)
                .show();
          }
        },
        child: Text(
          'Cambiar contraseña',
          style: TextStyle(
              color: colores.pri_blanco,
              fontFamily: constantes.tipo_fuente_poppins,
              fontSize: 17),
        ));
  }
}
