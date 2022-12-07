
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/avisos/models/aviso_model.dart';
import 'package:movil_ganaseguros/avisos/providers/aviso_provider.dart';
import 'package:provider/provider.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;

class ListaAvisoPage extends StatefulWidget {
  @override
  State<ListaAvisoPage> createState() => _ListaAvisoPageState();
}

class _ListaAvisoPageState extends State<ListaAvisoPage> {

  @override
  void initState() {
    // TODO: implement initState
    obtieneListaAviso(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final avisoProvider = Provider.of<AvisoProvider>(context,listen: false);
    return Scaffold(
      body: _crearListaAviso(avisoProvider.lstAvisoModel),

    );
  }
  Widget _crearListaAviso(List<AvisoModel> lstAviso) {
    return ListView.builder(
        itemCount: lstAviso.length,
        itemBuilder: (BuildContext context, int index) {
          return _crearItemAviso(pAvisoModel: lstAviso[index]);
        });
  }
  Widget _crearItemAviso({required AvisoModel pAvisoModel}) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(width: 1, color: colores.sec_verde_oscuro)),
        child: Container(
          padding: EdgeInsets.all(14.0),
          child: Column(
            children: <Widget>[
              _imagenAviso(pAvisoModel),
              _tituloAviso(pAvisoModel),
              _contenidoAviso(pAvisoModel),
              _fechaAviso(pAvisoModel)
            ],
          ),
        ));
  }
  Widget _tituloAviso(AvisoModel pAvisoModel) {
    if (pAvisoModel.titulo!.trim() != "") // titulo obligatorio
      return Column(
        children: [
          Text(
            pAvisoModel.titulo!.trim().toString(),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
        ],
      );
    else
      return Row();
  }

  Widget _imagenAviso(AvisoModel pAvisoModel) {

      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          child: Container(
            //width: MediaQuery.of(context).size.width * 0.98,
            child: FadeInImage(
              placeholder: AssetImage('assets/cargando.gif'),
              image: NetworkImage(pAvisoModel.enlace!.trim()),
            ),
          ),
        ),
      );
  }

  Column _contenidoAviso(AvisoModel pAvisoModel) {
    if (pAvisoModel.contenido!.trim() != "")
      return Column(children: <Widget>[
        Divider(
          color: Colors.indigo,
        ),
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

  Widget _fechaAviso(AvisoModel pAvisoModel) {
    if (pAvisoModel.fechaAviso!=null && pAvisoModel.fechaAviso!.trim() != "")
      return Container(
        //width: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          children: [
            Divider(
              color: Colors.indigo,
            ),

              Expanded(
                child: SizedBox(),
              ),
              Text(
                "fecha publicación: ",
                style: Theme.of(context).textTheme.bodyText1,
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
  obtieneListaAviso (BuildContext context)async{
    final avisoProvider = Provider.of<AvisoProvider>(context,listen: false);
    await avisoProvider.obtenerAvisos();
  }

}
