import 'package:flutter/material.dart';
import 'package:yomak/AppScreens/AvatarsScreen.dart';
import 'package:yomak/AppScreens/ContentScreen.dart';
import 'package:yomak/AppScreens/ProfileScreen.dart';
import 'AppScreens/WelcomeScreen.dart';
import 'AppScreens/LoginScreen.dart';
import 'AppScreens/RegisterScreen.dart';
import 'AppScreens/CategoryScreen.dart';
import 'AppScreens/NewsScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'WS',
      routes: {
        'WS': (context) => WelcomeScreen(),
        'RS': (context) => RegisterScreen(),
        'LS': (context) => LoginScreen(),
        'CS': (context) => CategoryScreen(),
        'NS': (context) => NewsScreen(),
        'CoS': (context) => ContentScreen(),
        'AS': (context) => AvatarsScreen(),
        'PS': (context) => ProfileScreen(),
      },
    );
  }
}
