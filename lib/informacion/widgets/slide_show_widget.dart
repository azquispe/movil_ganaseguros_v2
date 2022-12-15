import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:movil_ganaseguros/informacion/models/oferta_model.dart';
import 'package:movil_ganaseguros/informacion/providers/oferta_provider.dart';
import 'package:movil_ganaseguros/informacion/widgets/circular_progress_widget.dart';
import 'package:movil_ganaseguros/utils/colores.dart' as colores;

import 'package:movil_ganaseguros/utils/estilos.dart';
import 'package:provider/provider.dart';

class SlideShowWidget extends StatefulWidget {
  @override
  State<SlideShowWidget> createState() => _SlideShowWidgetState();
}

class _SlideShowWidgetState extends State<SlideShowWidget> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<OfertaProvider>(context, listen: false).obtenerOfertas();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ofertaProvider = Provider.of<OfertaProvider>(context);
    
    return ofertaProvider.lstOfertaModel.length>0 && !ofertaProvider.descargandoOferta?
    ImageSlideshow(
        onPageChanged: (value) {
          debugPrint(
              'Page changed: $value'); // al hacer click podemos hacer algo
        },
        autoPlayInterval: 4000,
        isLoop: true,
        height: 300,
        children: ofertaProvider.lstOfertaModel
            .map((item) => Container(
                  child: Column(
                    children: [
                      item.enlace!=null? FadeInImage(
                        height: MediaQuery.of(context).size.width * 0.50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        placeholder: AssetImage('assets/gif/loading.gif'),
                        image: NetworkImage(item.enlace.toString()),
                        fit: BoxFit.fill,
                      ):Container(),
                      item.titulo!=null?Text(item.titulo.toString(),
                          style: Theme.of(context).textTheme.subtitle1):Container(),
                      item.contenido!=null?Text(item.contenido.toString(),
                          style: Theme.of(context).textTheme.bodyText1):Container()
                    ],
                  ),
                ))
            .toList()): (ofertaProvider.descargandoOferta==true)? Center(

        child: Column(
          children: [
            Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressWidget(),
                    SizedBox(height: 10,),
                    Text("Cargando Ofertas")
                  ],
                ),
              ),
            ),
          ],
        ),
    ):Container(height: 300,child: Center(child: Text("No existe Ofertas")));
  }


}
