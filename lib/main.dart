import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seyahat_asistani/core/init/providers/provider_list.dart';
import 'package:seyahat_asistani/view/splash/view/splash_view.dart';

import 'core/init/navigation/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _init();
  runApp(MultiProvider(
    providers: [...ApplicationProvider.instance.dependItems],
    child: const MyApp(),
  ));
}

late final FirebaseAuth firebaseAuth;

Future _init() async {
  await Firebase.initializeApp();
  firebaseAuth = FirebaseAuth.instance;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      title: 'Seyahat Asistani',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const SplashView(),
    );
  }
}
