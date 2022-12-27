import 'package:movil_ganaseguros/login/providers/datos_usuario_provider.dart';
import 'package:movil_ganaseguros/solicitar_seguro/services/dominio_service.dart';
import 'package:movil_ganaseguros/utils/models/dominio_model.dart';
import 'package:movil_ganaseguros/solicitar_seguro/providers/solicita_seguro_provider.dart';
import 'package:movil_ganaseguros/informacion/widgets/custom_bottom_navigator_widget.dart';
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:movil_ganaseguros/utils/constantes.dart' as constantes;
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:movil_ganaseguros/utils/dialogos.dart';
import 'package:movil_ganaseguros/utils/providers/dominio_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SolicitarSeguroPage extends StatefulWidget {
  @override
  State<SolicitarSeguroPage> createState() => _SolicitarSeguroPageState();
}

class _SolicitarSeguroPageState extends State<SolicitarSeguroPage> {
  @override
  void initState() {

    WidgetsBinding.instance!.addPostFrameCallback((_) async  {
      Provider.of<DominioProvider>(context, listen: false).obtenerCiudadDominio();
      Provider.of<DominioProvider>(context, listen: false).obtenerTipoProductoDominio();
    });


    super.initState();
  }

  Widget build(BuildContext context) {
    final datosUsuarioProvider = Provider.of<DatosUsuarioProvider>(context);
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
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Text(
              textAlign: TextAlign.center,
              'Solicita tu Seguro',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 10,
            ),
            Card(
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _crearNombres(),
                      SizedBox(
                        height: 10,
                      ),
                      _crearPaterno(),
                      SizedBox(
                        height: 10,
                      ),
                      _crearMaterno(),
                      SizedBox(
                        height: 10,
                      ),
                      _crearCorreo(),
                      SizedBox(
                        height: 10,
                      ),
                      _crearCiudad(),
                      SizedBox(
                        height: 10,
                      ),
                      _crearTipoProducto(),
                      SizedBox(
                        height: 10,
                      ),
                      _creaTieneSeguroNosotros(),
                      SizedBox(
                        height: 10,
                      ),
                      _crearTieneSeguroConOtros(),
                      SizedBox(
                        height: 10,
                      ),
                      _creaDescribaSolicitud(),
                      SizedBox(
                        height: 10,
                      ),
                      _creaBtoEnviarSolicitud()
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigatorWidget(),
    );
  }

  Widget _crearNombres() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    return TextFormField(
      controller: solicitaSeguroProvider.txtNombreController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.trim() == "") {
          return 'Campo requerido';
        }
        return null;
      },
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: 'Nombre(s)',
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: colores.pri_verde_claro, width: 2))),
    );
  }

  Widget _crearPaterno() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    return TextFormField(
      controller: solicitaSeguroProvider.txtApellidoController,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.bodyText1,
      validator: (value) {
        if (value == null || value.trim() == "") {
          return 'Campo requerido';
        }
        return null;
      },
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: 'Apellido(s)',
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: colores.pri_verde_claro, width: 2))),
    );
  }

  Widget _crearMaterno() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    return TextFormField(
      controller: solicitaSeguroProvider.txtTelCelController,
      keyboardType: TextInputType.number,
      style: Theme.of(context).textTheme.bodyText1,
      validator: (value) {
        if (value == null || value.trim() == "") {
          return 'Campo requerido';
        }
        return null;
      },
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: 'Teléfono Celular',
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: colores.pri_verde_claro, width: 2))),
    );
  }

  Widget _crearCorreo() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    return TextFormField(
      controller: solicitaSeguroProvider.txtCorreoController,
      keyboardType: TextInputType.emailAddress,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: 'Correo',
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: colores.pri_verde_claro, width: 2))),
    );
  }

  Widget _crearCiudad() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    final dominioProvider = Provider.of<DominioProvider>(context);
    if (dominioProvider.lstCiudad.isNotEmpty) {
      return DropdownButtonFormField(
        value: solicitaSeguroProvider.ciudadId,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodyText1,
            labelText: 'Ciudad',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: colores.pri_verde_claro, width: 2))),
        items: dominioProvider.lstCiudad.map((e) {
          /// Ahora creamos "e" y contiene cada uno de los items de la lista.
          return DropdownMenuItem(
              child: Text(e.descripcion!), value: e.dominioId);
        }).toList(),
        onChanged: (int? valor) {
          solicitaSeguroProvider.ciudadId = valor!;
          /*setState(() {
            solicitaSeguroProvider.ciudadId = valor!;
          });*/
        },
      );
    } else {
      return TextFormField(
        enabled: false,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodyText1,
            labelText: 'Cargando Ciudad .....',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: colores.pri_verde_claro, width: 2))),
      );
    }
  }

  Widget _crearTipoProducto() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    final dominioProvider = Provider.of<DominioProvider>(context);
    if (dominioProvider.lstTipoProducto.isNotEmpty) {
      return DropdownButtonFormField(
        value: solicitaSeguroProvider.tipoProductoId,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodyText1,
            labelText: 'Tipo de producto',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: colores.pri_verde_claro, width: 2))),
        items: dominioProvider.lstTipoProducto.map((e) {
          /// Ahora creamos "e" y contiene cada uno de los items de la lista.
          return DropdownMenuItem(
              child: Text(e.descripcion!), value: e.dominioId);
        }).toList(),
        onChanged: (int? valor) {
          solicitaSeguroProvider.tipoProductoId = valor!;
          /*setState(() {
            solicitaSeguroProvider.tipoProductoId = valor!;
          });*/
        },
      );
    } else {
      return TextFormField(
        enabled: false,
        keyboardType: TextInputType.text,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodyText1,
            labelText: 'Cargando Tipo de Producto .....',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: colores.pri_verde_claro, width: 2))),
      );
    }
  }

  Widget _creaTieneSeguroNosotros() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Tienes algún seguro \n contratado con nosotros?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Switch(
            value: solicitaSeguroProvider.boolTieneSeguroNosotros,
            activeColor: colores.pri_verde_claro,
            onChanged: (value) {
              solicitaSeguroProvider.boolTieneSeguroNosotros = !solicitaSeguroProvider.boolTieneSeguroNosotros;
            }),
        Text(
          solicitaSeguroProvider.boolTieneSeguroNosotros ? "SI" : "NO",
          //style: Estilos.stlTextoSubTitulo(),
          style: Theme.of(context).textTheme.bodyText1,
        )
        // cuando SELECCIONES SI, habilitra un campo donde ponga su seguro actual
      ],
    );
  }

  Widget _crearTieneSeguroConOtros() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Tienes algún seguro contratado \n con otra compañía de seguros?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Switch(
          // This bool value toggles the switch.
          value: solicitaSeguroProvider.boolTieneSeguroOtros,
          activeColor: colores.pri_verde_claro,
          onChanged: (value) {
            solicitaSeguroProvider.boolTieneSeguroOtros =
                !solicitaSeguroProvider.boolTieneSeguroOtros;
          },
        ),
        Text(
          solicitaSeguroProvider.boolTieneSeguroOtros ? "SI" : "NO",
          //style: Estilos.stlTextoSubTitulo(),
          style: Theme.of(context).textTheme.bodyText1,
        )
        // cuando SELECCIONES SI, habilitra un campo donde ponga su seguro actual
      ],
    );
  }

  Widget _creaDescribaSolicitud() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    return TextFormField(
      controller: solicitaSeguroProvider.txtDescripcionController,
      maxLines: 3,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.bodyText1,
          labelText: 'Describa su solicitud',
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: colores.pri_verde_claro, width: 2))),
    );
  }

  Widget _creaBtoEnviarSolicitud() {
    final solicitaSeguroProvider = Provider.of<SolicitaSeguroProvider>(context);
    return ElevatedButton(
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
          //if (_formKey.currentState!.validate()) {
          bool res = await showDialog(
            context: context,
            builder: (context) => FutureProgressDialog(
                solicitaSeguroProvider.enviarSolicitudSeguro(),
                message: Text('Procesando...')),
          );
          if (res) {
            Dialogos.dialogoInformativo(
                    pTitulo: "Solicitud de Póliza",
                    pDescripcion:
                        "En breve un especialista de GanaSeguros se comunicará contigo",
                    pContext: context,
                    pBoton: "Aceptar",
                    pTipoAlerta: AlertType.success)
                .show();

            limpiarFormulario(context);
          } else {
            Dialogos.dialogoInformativo(
                    pTitulo: "Solicitud de Póliza",
                    pDescripcion: "No se pudo envair su Solicitud",
                    pContext: context,
                    pBoton: "Aceptar",
                    pTipoAlerta: AlertType.error)
                .show();
          }
          //}
        },
        child: Text(
          'Enviar Solicitud',
          style: TextStyle(
              color: colores.pri_blanco,
              fontFamily: constantes.tipo_fuente_poppins,
              fontSize: 17),
        ));
  }

  void limpiarFormulario(BuildContext context) {
    final solicitaSeguroProvider =
        Provider.of<SolicitaSeguroProvider>(context, listen: false);
    solicitaSeguroProvider.txtNombreController.text = "";
    solicitaSeguroProvider.txtApellidoController.text = "";
    solicitaSeguroProvider.txtTelCelController.text = "";
    solicitaSeguroProvider.txtCorreoController.text = "";
    //solicitaSeguroProvider.ciudad = "";
    solicitaSeguroProvider.boolTieneSeguroNosotros = false;
    solicitaSeguroProvider.boolTieneSeguroOtros = false;
    //solicitaSeguroProvider.tipoProductoId = "";
  }
}
