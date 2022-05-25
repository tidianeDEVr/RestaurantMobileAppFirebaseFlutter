import 'package:flutter/material.dart';
import 'package:food_ui_kit/screens/onboarding/onboarding_scrreen.dart';
import 'package:food_ui_kit/theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brasil Burger',
      theme: buildThemeData(),

      /// [SizeConfig().init(context)]
      home: OnboardingScreen(),
    );
  }
}
