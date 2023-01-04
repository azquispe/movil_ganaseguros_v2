import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:movil_ganaseguros/login/providers/login_provider.dart';
import 'package:movil_ganaseguros/utils/estilos.dart';
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colores.pri_blanco,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 210,
            child: DrawerHeader(
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Bienvenido", style: Theme.of(context).textTheme.headline5),
                _crearNombreUsuario(context),

              ],
            )
                //UserAccountDrawerHeader
                ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            iconColor: colores.pri_verde_claro,
            title: Text(
              'Inicio ',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'inicio_page');
            },
          ),
          ListTile(
            leading: Icon(Icons.search_outlined),
            iconColor: colores.pri_verde_claro,
            title: Text(
              'Consulta Pólizas',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'consulta_poliza_historico_page');
            },
          ),
          ListTile(
            leading: Icon(Icons.assured_workload),
            iconColor: colores.pri_verde_claro,
            title: Text(
              'Solicitar Seguro',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'solicitar_seguro_page');
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_outlined),
            iconColor: colores.pri_verde_claro,
            title: Text(
              'Avisos',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'avisos_page');
            },
          ),
          ListTile(
            leading: Icon(Icons.map_outlined),
            iconColor: colores.pri_verde_claro,
            title: Text(
              'Encuentranos',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'encuentranos_page');
            },
          ),
          ListTile(
            leading: Icon(Icons.business),
            iconColor: colores.pri_verde_claro,
            title: Text(
              'Nosotros',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'nosotros_page');
            },
          ),
          _crearCambiarClave(context)
       ,
          Divider(
            color: colores.pri_verde_claro,
          ),
      SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(10),
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login_page');
              },
              child: Text('Cerrar sessión',
                  style: Theme.of(context).textTheme.subtitle2),
            ),
          )
        ],
      ),
    );
  }
  Widget _crearCambiarClave(BuildContext context) {
    final vDatosPersonaModel = Provider.of<LoginProvider>(context).datosPersonaModel;
    if(vDatosPersonaModel.personaId!=null && vDatosPersonaModel.personaId!>0){
      return ListTile(
        leading: Icon(Icons.key),
        iconColor: colores.pri_verde_claro,
        title: Text(
          'Cambiar clave',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, 'cambiar_clave_page');
        },
      );
    }else{
      return Container();
    }

  }
  Widget _crearNombreUsuario(BuildContext context) {
    final vDatosPersonaModel =
        Provider.of<LoginProvider>(context).datosPersonaModel;
    String nombreInvitado = "INVITADO";
    String nombreCompleto = vDatosPersonaModel.nombres != null
        ? vDatosPersonaModel.nombres.toString()
        : "";
    String apellidos = (vDatosPersonaModel.apellidoPaterno != null
            ? vDatosPersonaModel.apellidoPaterno.toString()
            : "") +
        (vDatosPersonaModel.apellidoMaterno != null
            ? vDatosPersonaModel.apellidoMaterno.toString()
            : "");
    if (nombreCompleto != "" || apellidos != "") {
      return Column(
        children: [
          Text(nombreCompleto + "\n" + apellidos, style: Theme.of(context).textTheme.subtitle2),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'actualizar_datos_usuario_page');
            },
            child: Text('Ver Datos',
                style: Theme.of(context).textTheme.subtitle2),
          )
        ],
      );
    } else {
      return Text(nombreInvitado, style: Theme.of(context).textTheme.subtitle2);
    }
  }
}
