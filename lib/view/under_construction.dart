import 'package:flutter/material.dart';
import 'package:map/config/app_image.dart';

class UnderConstruction extends StatefulWidget {
  const UnderConstruction({super.key});

  @override
  State<UnderConstruction> createState() => _UnderConstructionState();
}

class _UnderConstructionState extends State<UnderConstruction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImage.underConstruction),
          Text(
            "Under Developement".toUpperCase(),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
