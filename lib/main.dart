import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pet_food/Service/app.ervice.dart';
import 'package:pet_food/Service/notification.manager.dart';
import 'package:pet_food/View/Pages/FoodPage.ui.dart';
import 'package:pet_food/View/Pages/Home.ui.dart';
import 'package:pet_food/View/Pages/finalScreen.dart';
import 'package:pet_food/View/UiManager/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  CameraService.loadCameras();

  await NotificationManager.init(localNotificationsPlugin);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.themeData(),
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/foodPage': (_) => const FoodPage(),
        '/final': (_) => FinalScreen(),
      },
    );
  }
}
