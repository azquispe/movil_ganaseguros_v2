import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/avisos/models/aviso_model.dart';
import 'package:movil_ganaseguros/avisos/providers/aviso_provider.dart';
import 'package:movil_ganaseguros/informacion/widgets/circular_progress_widget.dart';
import 'package:movil_ganaseguros/informacion/widgets/custom_bottom_navigator_widget.dart';
import 'package:provider/provider.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:movil_ganaseguros/utils/api.dart' as api;

class AvisoPage extends StatefulWidget {
  @override
  State<AvisoPage> createState() => _AvisoPageState();
}

class _AvisoPageState extends State<AvisoPage> {

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<AvisoProvider>(context, listen: false).obtenerAvisos();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final  avisoProvider = Provider.of<AvisoProvider>(context);
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
      body: (avisoProvider.lstAvisoModel.length > 0 && !avisoProvider.descargandoAviso)
          ? _crearListaAviso(avisoProvider.lstAvisoModel,context)
          : avisoProvider.descargandoAviso==true?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressWidget(),
                    SizedBox(height: 10,),
                    Text("Cargando Avisos")
                  ],
                ),
              ):Center(child: Text("No existe Avisos")),
      bottomNavigationBar: CustomBottomNavigatorWidget(),
    );
  }

  Widget _crearListaAviso(List<AvisoModel> lstAviso, BuildContext context) {
    return ListView.builder(
        itemCount: lstAviso.length,
        itemBuilder: (BuildContext context, int index) {
          return _crearItemAviso(pAvisoModel: lstAviso[index],context: context);
        });
  }

  Widget _crearItemAviso({required AvisoModel pAvisoModel, required BuildContext context}) {
    return Card(
        color: colores.pri_blanco,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: colores.sec_verde_oscuro,
          ),
          borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
        ),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              _tituloAviso(pAvisoModel,context),
              _contenidoAviso(pAvisoModel,context),
              _imagenAviso(pAvisoModel,context),
              Divider(
                color: Colors.indigo,
              ),
              _fechaAviso(pAvisoModel,context)
            ],
          ),
        ),
    );
  }

  Widget _tituloAviso(AvisoModel pAvisoModel, BuildContext context) {
    if (pAvisoModel.titulo != null &&
        pAvisoModel.titulo!.trim() != "") // titulo obligatorio
      return Column(
        children: [
          Text(
            pAvisoModel.titulo!.trim().toString(),
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.center,
          ),
        ],
      );
    else
      return Row();
  }

  Widget _imagenAviso(AvisoModel pAvisoModel,BuildContext context) {
    if (pAvisoModel.documentoAdjuntoId != null && pAvisoModel.documentoAdjuntoId! > 0) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          child: Container(
            //width: MediaQuery.of(context).size.width * 0.98,
            child: FadeInImage(

              placeholder: AssetImage('assets/gif/loading.gif'),
              image: NetworkImage("${api.API_MOVIL_GANASEGURO}/app-web/v1/descargar-archivo/"+pAvisoModel.documentoAdjuntoId.toString()),
            ),
          ),
        ),
      );
    } else {
      return Column();
    }
  }

  Column _contenidoAviso(AvisoModel pAvisoModel,BuildContext context) {
    if (pAvisoModel.contenido != null && pAvisoModel.contenido!.trim() != "")
      return Column(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.90,
          child: Text(
            pAvisoModel.contenido.toString(),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.left,
          ),
        ),
      ]);
    else {
      return Column();
    }
  }

  Widget _fechaAviso(AvisoModel pAvisoModel,BuildContext context) {
    if (pAvisoModel.fechaAviso != null && pAvisoModel.fechaAviso!.trim() != "")
      return Container(
        //width: MediaQuery.of(context).size.width * 0.95,
        child: Row(children: [
          Text(
            "fecha publicación: ",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Container(
            child: Text(
              pAvisoModel.fechaAviso.toString(),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.right,
            ),
          ),
        ]),
      );
    else {
      return Row();
    }
  }
}
