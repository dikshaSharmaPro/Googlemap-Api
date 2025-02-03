import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/view/login_screen.dart';
import 'package:map/view/map_screen.dart';
import 'package:map/view/under_construction.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(250),
        ),
        child: SizedBox(
          width: 250,
          child: Drawer(
            child: ListView(
              children: <Widget>[
                const UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  accountName: Text(
                    '',
                    style: TextStyle(
                      fontSize: 1,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  accountEmail: Text(
                    'Cabo Cab',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Get.to(const UnderConstruction());
                    // Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.person,
                    size: 26.0,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Saved Places',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Get.to(() => const MapScreen());
                  },
                  leading: const Icon(
                    Icons.place,
                    size: 26.0,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Ride History',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Get.to(const UnderConstruction());
                  },
                  leading: const Icon(
                    Icons.history,
                    size: 26.0,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Payments',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Get.to(const UnderConstruction());
                  },
                  leading: const Icon(
                    Icons.payment,
                    size: 26.0,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isUserLoggedIn', false);
                    Get.offAll(() => LoginScreen());
                  },
                  leading: const Icon(
                    Icons.logout,
                    size: 26.0,
                    color: Colors.black,
                  ),
                ),
                const Divider(
                  color: Colors.black38,
                ),
                ListTile(
                  title: const Text(
                    'Close Menu',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.close,
                    size: 26.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
