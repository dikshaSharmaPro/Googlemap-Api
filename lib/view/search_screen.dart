import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/view/main_homescreen.dart';
import 'package:map/view/map_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            searchField(true),
            GestureDetector(
              onTap: () => Get.to(() => const MapScreen()),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ListTile(
                    leading: Icon(Icons.stars),
                    title: Text(
                      "Saved Places",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.add_location),
                    title: Text(
                      "Set Location on Map",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text(
                      "Delhi",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Delhi 6"),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text(
                      "52 metro station",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Sector 53, Noida"),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_pin),
                    title: Text(
                      "Okhla",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Delhi -DND"),
                  ),
                  ListTile(
                    leading: Icon(Icons.add_location_alt_sharp),
                    title: Text(
                      "ADD A NEW PLACE",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
