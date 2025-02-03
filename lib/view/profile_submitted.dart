import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/config/app_image.dart';
import 'package:map/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSubmitted extends StatelessWidget {
  const ProfileSubmitted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: GestureDetector(
        onTap: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isUserLoggedIn', true);
          Get.offAll(() => HomeScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 60,
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xfffbb448), Color(0xfff7892b)])),
            child: const Text(
              "Next",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImage.tickGif),
          const Text("Your profile has been submited successfully.")
        ],
      )),
    );
  }
}
