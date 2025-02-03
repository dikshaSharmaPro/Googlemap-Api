import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/view/main_homescreen.dart';
import 'package:map/view/map_screen.dart';
import 'package:map/view/under_construction.dart';

import '../controller/home_controller.dart'; // Make sure to import your HomeController

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      MainHomeScreen(),
      // mainHomeScreen(context),
      const MapScreen(),
      const UnderConstruction(),
      const UnderConstruction(),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Book Cab',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Person',
            ),
          ],
          currentIndex: homeController.selectedIndex.value,
          backgroundColor: Colors.grey,
          elevation: 50,
          enableFeedback: true,
          // fixedColor: Colors.black,
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          selectedItemColor: Colors.amber[800],
          onTap: homeController.onItemTapped,
        ),
      ),
      body: Obx(() => DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: widgetOptions.elementAt(homeController.selectedIndex.value),
          )),
    );
  }
}
