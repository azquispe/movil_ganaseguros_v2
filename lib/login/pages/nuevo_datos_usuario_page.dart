import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:movil_ganaseguros/informacion/widgets/custom_bottom_navigator_widget.dart';
import 'package:movil_ganaseguros/login/providers/datos_usuario_provider.dart';
import 'package:movil_ganaseguros/solicitar_seguro/services/dominio_service.dart';
import 'package:movil_ganaseguros/utils/dialogos.dart';
import 'package:movil_ganaseguros/utils/models/dominio_model.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:movil_ganaseguros/utils/constantes.dart' as constantes;
import 'package:movil_ganaseguros/utils/providers/dominio_provider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NuevoDatosUsuarioPage extends StatefulWidget {
  const NuevoDatosUsuarioPage({Key? key}) : super(key: key);

  @override
  State<NuevoDatosUsuarioPage> createState() => _NuevoDatosUsuarioPageState();
}

class _NuevoDatosUsuarioPageState extends State<NuevoDatosUsuarioPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      //Provider.of<DatosUsuarioProvider>(context, listen: false).obtenerDatosPersonaAformulario(); // para llenar formulario
      Provider.of<DominioProvider>(context, listen: false).obtenerCiudadExpedido();
      Provider.of<DominioProvider>(context, listen: false).obtenerGenero();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final datosUsuarioProvider = Provider.of<DatosUsuarioProvider>(context);
    final dominioProvider = Provider.of<DominioProvider>(context);

    final _formKey = GlobalKey<FormState>();
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
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Text(
              textAlign: TextAlign.center,
              'Registra tus Datos',
              //style: Estilos.stlTextoTitulo(),
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
                      TextFormField(
                        controller: datosUsuarioProvider.txtNombresController,
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
                                borderSide: BorderSide(
                                    color: colores.pri_verde_claro, width: 2))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: datosUsuarioProvider.txtPaternoController,
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
                            labelText: 'Apellido Paterno',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colores.pri_verde_claro, width: 2))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: datosUsuarioProvider.txtMaternoController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            labelText: 'Apellido Materno',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colores.pri_verde_claro, width: 2))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller:
                            datosUsuarioProvider.txtNroDocumentoController,
                        maxLength: 100,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim() == "") {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            labelText: 'Nro de Documento',
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colores.pri_verde_claro, width: 2))),
                      ),
                      Row(
                        children: [
                          Flexible(
                              flex: 4,
                              child: dominioProvider.lstCiudadExpedido.isNotEmpty? DropdownButtonFormField(
                                value: datosUsuarioProvider.ciudadExpedidoId,
                                style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                    labelStyle:
                                        Theme.of(context).textTheme.bodyText1,
                                    labelText: 'Ciudad Expedido',
                                    border: OutlineInputBorder(),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: colores.pri_verde_claro,
                                            width: 2))),
                                items:
                                    dominioProvider.lstCiudadExpedido.map((e) {
                                  /// Ahora creamos "e" y contiene cada uno de los items de la lista.
                                  return DropdownMenuItem(
                                      child: Text(e.descripcion!),
                                      value: e.dominioId);
                                }).toList(),
                                onChanged: (int? valor) {
                                  datosUsuarioProvider.ciudadExpedidoId = valor!;
                                },
                              ): TextFormField(
                                enabled: false,
                                keyboardType: TextInputType.text,
                                style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                    labelStyle: Theme.of(context).textTheme.bodyText1,
                                    labelText: 'Cargando .....',
                                    border: OutlineInputBorder(),
                                    errorBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: colores.pri_verde_claro, width: 2))),
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            flex: 4,
                            child: TextFormField(
                              controller: datosUsuarioProvider.txtComplementoController,
                              maxLength: 100,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                  labelText: "Complemento",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  border: OutlineInputBorder(),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colores.pri_verde_claro,
                                          width: 2))),
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: datosUsuarioProvider.txtCelularController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.trim() == "") {
                            return 'Campo requerido';
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            labelText: 'Número de Celular',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colores.pri_verde_claro, width: 2))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: datosUsuarioProvider.txtCorreoController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText1,
                        decoration: InputDecoration(
                            labelStyle: Theme.of(context).textTheme.bodyText1,
                            labelText: 'Correo Electrónico',
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colores.pri_verde_claro, width: 2))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          readOnly: true,
                          controller: datosUsuarioProvider.txtFechaNacimientoController,
                          maxLength: 100,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.trim() == "") {
                              return 'Campo requerido';
                            }
                            return null;
                          },
                          style: Theme.of(context).textTheme.bodyText1,
                          decoration: InputDecoration(
                              labelText:
                                  "Fecha de Nacimiento, formato (dd/mm/yyyy)",
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              border: OutlineInputBorder(),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: colores.pri_verde_claro,
                                      width: 2))),
                          onTap: () async {
                            DateTime? newdate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime.now());
                            if (newdate == null) return;
                            datosUsuarioProvider
                                    .txtFechaNacimientoController.text =
                                newdate.day.toString().padLeft(2, '0') +
                                    "/" +
                                    newdate.month.toString().padLeft(2, '0') +
                                    "/" +
                                    newdate.year.toString().padLeft(2, '0');
                            ;
                          }),
                      ElevatedButton(
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
                            Dialogos.dialogoInformativo(
                                pTitulo: "Registro de Cuenta",
                                pDescripcion:
                                "EN PROCESO",
                                pContext: context,
                                pBoton: "Aceptar",
                                pTipoAlerta: AlertType.success)
                                .show();

                            /*if (_formKey.currentState!.validate()) {
                              bool res = await showDialog(
                                context: context,
                                builder: (context) => FutureProgressDialog(
                                    datosUsuarioProvider.actualizarPersona(),
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

                                    datosUsuarioProvider.obtenerDatosPersonaAformulario();
                              } else {
                                Dialogos.dialogoInformativo(
                                    pTitulo: "Solicitud de Póliza",
                                    pDescripcion: "No se pudo envair su Solicitud",
                                    pContext: context,
                                    pBoton: "Aceptar",
                                    pTipoAlerta: AlertType.error)
                                    .show();
                              }
                            }*/
                          },
                          child: Text(
                            'Actualizar Datos',
                            style: TextStyle(
                                color: colores.pri_blanco,
                                fontFamily: constantes.tipo_fuente_poppins,
                                fontSize: 17),
                          ))
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigatorWidget(),
    );
  }
}
