import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seyahat_asistani/view/splash/view/splash_view.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Seyahat Asistani',
      home: SplashView(),
    );
  }
}
