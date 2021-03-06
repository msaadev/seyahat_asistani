import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/init/cache/cache_manager.dart';
import 'core/init/navigation/navigation_service.dart';
import 'view/splash/view/splash_view.dart';

late List<CameraDescription> cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.location.request();
  await _init();
  runApp( const MyApp(),
  );
}

late final FirebaseAuth firebaseAuth;

Future _init() async {
  await Firebase.initializeApp();
  firebaseAuth = FirebaseAuth.instance;
  cameras = await availableCameras();
  await CacheManager.prefrencesInit();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Color(0xFF012340),
          primaryColor: Color(0xFF04D939),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF04D939),
              foregroundColor: Color(0xFF012340)),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.light)),
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      title: 'Seyahat Asistani',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const Scaffold(body: SafeArea(child: SplashView())),
    );
  }
}
