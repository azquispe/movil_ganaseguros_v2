import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
class Dialogos{
  static Alert dialogoInformativo({required BuildContext pContext, required String pTitulo, required String pDescripcion, required String pBoton, required AlertType pTipoAlerta, String pPathRedirect=""}) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.fromTop,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: Theme.of(pContext).textTheme.bodyText1!,
        animationDuration: Duration(milliseconds: 400),
        titleStyle: Theme.of(pContext).textTheme.subtitle1!,
        //First to chars "55" represents transparency of color
        overlayColor: Color(0x55000000),
        alertElevation: 0,
        alertAlignment: Alignment.center);

      // con titulo?
    if(pTitulo!="")
    return  Alert(
      context: pContext,
      style: alertStyle,
      type: pTipoAlerta,
      title: pTitulo,
      desc: pDescripcion,
      buttons: [
        DialogButton(
          child: Text(
            pBoton,
            style: TextStyle(color: colores.pri_blanco, fontSize: 20),
          ),
          onPressed: ()  {
            Navigator.pop(pContext);
            if(pPathRedirect!=""){
              Navigator.pushNamed(pContext, pPathRedirect);
            }
          },
          color: colores.sec_verde_claro,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    );

    else
    return  Alert(
      context: pContext,
      style: alertStyle,
      type: pTipoAlerta,
      desc: pDescripcion,
      buttons: [
        DialogButton(
          child: Text(
            pBoton,
            style: TextStyle(color: colores.pri_blanco, fontSize: 20),
          ),
          onPressed: ()  {
            Navigator.pop(pContext);
            if(pPathRedirect!=""){
              Navigator.pushNamed(pContext, pPathRedirect);
            }
          },
          color: colores.sec_verde_claro,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    );

  }
}