import 'package:badges/badges.dart';
import 'package:movil_ganaseguros/avisos/providers/aviso_provider.dart';
import 'package:movil_ganaseguros/informacion/widgets/custom_bottom_navigator_widget.dart';
import 'package:flutter/material.dart';
import 'package:movil_ganaseguros/informacion/widgets/slide_show_widget.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;
import 'package:provider/provider.dart';
import '../widgets/card_inicio_widget.dart';
import '../widgets/drawer_widget.dart';

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final avisoProvider = Provider.of<AvisoProvider>(context);
    return Scaffold(
      backgroundColor: colores.pri_blanco,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: colores.pri_verde_claro),
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          child: Image(
              width: 200,
              height: 50,
              image: AssetImage('assets/img/logo_ganaseguros_400.png')),
        ),
        actions: <Widget>[
          avisoProvider.avisosNuevos > 0
              ? Badge(
                  badgeContent: Text(avisoProvider.avisosNuevos.toString(),
                      style:
                          TextStyle(fontSize: 20, color: colores.pri_blanco)),
                  badgeColor: Colors.deepOrange,
                  child: IconButton(
                    icon: Icon(Icons.notifications, size: 30),
                    onPressed: () {
                      avisoProvider.avisosNuevos = 0;
                      Navigator.pushNamed(context, 'avisos');
                    },
                  ))
              : IconButton(
                  icon: Icon(Icons.notifications, size: 30),
                  onPressed: () {
                    avisoProvider.avisosNuevos = 0;
                    Navigator.pushNamed(context, 'avisos');
                  },
                ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      /*body: Stack(
        children: [
          // Home Body
          _HomeBody()
        ],
      ),*/
      body: _HomeBody(),
      drawer: DrawerWidget(),
      bottomNavigationBar: CustomBottomNavigatorWidget(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Text(' un seguro al alcance de tu mano que te acompaña a todos lados'),
            const SizedBox(
              height: 10,
            ),

            Text('Nuestras Ofertas',
                style: Theme.of(context).textTheme.headline5),
            Card(
                elevation: 0,
                margin: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: colores.sec_verde_oscuro,
                  ),
                  borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                ),
                child: Container(
                  child: SlideShowWidget(),
                )),

            const SizedBox(
              height: 10,
            ),
            // titulos

            Text('¿Que necesitas?',
                //style: Estilos.stlTextoTitulo()
                style: Theme.of(context).textTheme.headline5),
            SizedBox(
              height: 5,
            ),
            CardInicioWidget(),
          ],
        ),
      ),
    );
  }
}
