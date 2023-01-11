import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_local_service.dart';



// SHA1: 1D:4F:38:94:62:06:9F:C6:75:A7:73:BD:E4:B0:DA:27:80:B1:9D:F0
// P8 - KeyID: VYZH37GGZ9


// documentacion de firebase
// https://firebase.flutter.dev/docs/messaging/overview

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler( RemoteMessage message ) async {

    // print( 'onBackground Handler ${ message.messageId }');
    print( message.data );

    _messageStream.add( message.data['id'] );
  }

  static Future _onMessageHandler( RemoteMessage message ) async {
    mostrarNotificacion(message.notification!.title!,message.notification!.body!);  // cuando esta la app abierto no mostraba notifcioan, con esta linea ya muestra
    // print( 'onMessage Handler ${ message.messageId }');
    print( message.data );
    _messageStream.add( message.data['id'] );
  }

  static Future _onMessageOpenApp( RemoteMessage message ) async {
    // print( 'onMessageOpenApp Handler ${ message.messageId }');
    print( message.data );
    _messageStream.add( message.data['id'] );
  }





  static Future initializeApp() async {

    // Push Notifications
    await Firebase.initializeApp();

    await requestPermission();

    /*token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');*/

    // Handlers

    FirebaseMessaging.onBackgroundMessage( _backgroundHandler );
    FirebaseMessaging.onMessage.listen( _onMessageHandler );
    FirebaseMessaging.onMessageOpenedApp.listen( _onMessageOpenApp );



    // Local Notifications
    messaging.subscribeToTopic('anuncios_ganaseguros_2022_dev'); // para recibir push



  }

  // Apple / Web
  static requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true
    );

    print('User push notification status ${ settings.authorizationStatus }');

  }


  static closeStreams() {
    _messageStream.close();
  }
}