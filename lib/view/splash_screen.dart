import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/config/app_image.dart';
import 'package:map/view/home_screen.dart';
import 'package:map/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    whereToNavigate();
  }

  whereToNavigate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isUserLoggedIn') ?? false;
    if (isLoggedIn) {
      Timer(const Duration(seconds: 5), () {
        Get.offAll(() => HomeScreen());
      });
    } else {
      Timer(const Duration(seconds: 5), () {
        Get.offAll(() => LoginScreen());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImage.logoGif, width: 400, height: 400),
          const Text("Cabo Cab",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
        ],
      )),
    );
  }
}
