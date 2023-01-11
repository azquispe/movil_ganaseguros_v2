import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movil_ganaseguros/login/providers/login_provider.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:movil_ganaseguros/utils/dialogos.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    //final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 110.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 0.0),
                      spreadRadius: 3.0)
                ]),
            child: Column(
              children: <Widget>[
                Text('Inicia sessión',
                    style: Theme.of(context).textTheme.headline5),
                Text('Ingresa y confirma tu usuario y contraseña',
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20.0),
                _crearUsuario(context),
                SizedBox(height: 20.0),
                _crearPassword(context),
                SizedBox(height: 20.0),
                _crearBotonLogin(context),
                SizedBox(height: 10.0),
                _crearBotonInvitado(context)

              ],
            ),
          ),
          _crearNuevo(context)
        ],
      ),
    );
  }

  Widget _crearUsuario(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          controller: loginProvider.txtUsuarioController,
          keyboardType: TextInputType.text,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.bodyText1,
              labelText: 'Usuario',
              border: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: colores.pri_verde_claro, width: 2))),
        ));
  }

  Widget _crearPassword(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        obscureText: true,
        controller: loginProvider.txtPasswordController,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.bodyText1,
            labelText: 'Contraseña',
            border: OutlineInputBorder(),
            errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: colores.pri_verde_claro, width: 2))),
      ),
    );
  }

  Widget _crearBotonLogin(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            // fromHeight use double.infinity as width and 40 is the height
            elevation: 0,
            backgroundColor: colores.pri_verde_claro,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () async {
            bool res = await showDialog(
              context: context,
              builder: (context) => FutureProgressDialog(
                  loginProvider.login(),
                  message: Text('Procesando...')),
            );
            if (res) {
              loginProvider.limpiarUsuarioContrasena();
              Navigator.pushNamed(context, 'inicio_page');

            } else {
              Dialogos.dialogoInformativo(pTitulo: "Autenticación",pDescripcion: "Usuario o Contraseña incorrecta",pContext: context,pBoton: "Aceptar",pTipoAlerta: AlertType.error).show();
            }
          },
          child: Text('Iniciar sessión')),
    );
  }
  Widget _crearBotonInvitado(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            // fromHeight use double.infinity as width and 40 is the height
            elevation: 0,
            backgroundColor: Colors.transparent,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                    width: 2, // thickness
                    color: colores.pri_verde_claro // color
                ),
                // border radius

            ),
          ),
          onPressed: () async {
            loginProvider.limpiarUsuarioContrasena();
            loginProvider.eliminarDatosPersonaTodos();
            Navigator.pushNamed(context, 'inicio_page');
          },
          child: Text('Iniciar como invitado',style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: colores.pri_verde_claro,
                letterSpacing: 0.3,
                //fontSize: 22,
                fontWeight: FontWeight.normal),
          ),)),
    );
  }
  Widget _crearNuevo(BuildContext context) {
    return         Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes cuenta?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(width: 10,),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('nuevo_datos_usuario_page');
          },
          child:  Text('Crear ahora',style: Theme.of(context).textTheme.subtitle2 ),
        )
      ],
    );
  }
  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        colores.pri_verde_claro,
        colores.pri_verde_claro
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Image(
                  width: 80,
                  height: 80,
                  image: AssetImage('assets/icon/icono_app.jpg')),
              SizedBox(height: 10.0, width: double.infinity),
            ],
          ),
        )
      ],
    );
  }
}
