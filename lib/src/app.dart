import 'package:flutter/material.dart';
import 'package:test1/src/global.dart';
import 'package:test1/src/pages/home.dart';
import 'package:test1/src/pages/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: sharedPreferences.getBool('isloggedIn') !=null 
      ? HomePage()
      :SplashScreen()
    );
  }
}
