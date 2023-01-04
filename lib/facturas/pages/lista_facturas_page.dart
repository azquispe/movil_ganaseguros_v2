import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/facturas/models/datos_factura_model.dart';
import 'package:movil_ganaseguros/facturas/providers/datos_factura_provider.dart';
import 'package:movil_ganaseguros/informacion/widgets/custom_bottom_navigator_widget.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:movil_ganaseguros/utils/constantes.dart' as constantes;
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class ListaFacturasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datosFacturaProvider = Provider.of<DatosFacturaProvider>(context);

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
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: datosFacturaProvider.lstDatosFacturaModel.length,
            itemBuilder: (BuildContext context, int index) {
              return _crearItemInformacionFacturas(
                  pDatosFacturaModel:
                      datosFacturaProvider.lstDatosFacturaModel[index],
                  context: context);
            }),
      ),
      bottomNavigationBar: CustomBottomNavigatorWidget(),
    );
  }

  Widget _crearItemInformacionFacturas(
      {required DatosFacturaModel pDatosFacturaModel,
      required BuildContext context}) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'FECHA FACTURA:',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
              Text(
                pDatosFacturaModel.fechaFactura.toString(),
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
              Text(
                'NIT EMISOR:',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
              Text(
                pDatosFacturaModel.nitEmisor.toString(),
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'NOMBRE COMERCIAL:',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
              Text(
                pDatosFacturaModel.nombreComercial.toString(),
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'NRO DE FACTURA:',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
              Text(
                pDatosFacturaModel.numeroFactura.toString(),
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'MONTO:',
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
              Text(
                pDatosFacturaModel.monto.toString(),
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
              Divider(
                color: colores.sec_verde_oscuro,
              ),
              descargarFactura(pDatosFacturaModel, context)
            ],
          ),
        ));
  }

  Widget descargarFactura(
      DatosFacturaModel pDatosFacturaModel, BuildContext context) {
    if (pDatosFacturaModel.urlFactura!=null) {
      return Row(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Text(
            'Descargar Factura',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          IconButton(
            icon: const Icon(
              Icons.file_download,
              color: colores.sec_verde_petroleo,
            ),
            onPressed: () async {
              OpenFile.open(pDatosFacturaModel.urlFactura);
            },
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
