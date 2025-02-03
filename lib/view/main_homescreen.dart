import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/config/app_image.dart';
import 'package:map/view/drawer.dart';
import 'package:map/view/map_screen.dart';
import 'package:map/view/search_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MainHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),

      // Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: const BoxDecoration(
      //           color: Colors.white,
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             const CircleAvatar(
      //               radius: 40,
      //               backgroundImage:
      //                   NetworkImage('https://via.placeholder.com/150'),
      //             ),
      //             IconButton(
      //               icon: const Icon(Icons.close),
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.person),
      //         title: const Text('User Profile'),
      //         onTap: () {
      //           // Handle the user profile tap
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.logout),
      //         title: const Text('Logout'),
      //         onTap: () {
      //           // Handle the logout tap
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.book),
      //         title: const Text('Blog'),
      //         onTap: () {
      //           // Handle the blog tap
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.history),
      //         title: const Text('History'),
      //         onTap: () {
      //           // Handle the history tap
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.book_online),
      //         title: const Text('Book Pooja'),
      //         onTap: () {
      //           // Handle the book pooja tap
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        AppImage.homeImg,
                        fit: BoxFit.fill,
                      ),
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        searchField(false),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const SearchScreen());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[350],
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )),
                            height: 50,
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.stars,
                                    size: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Saved Places",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Suggestion",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildCategoryColumn(
                                image: Image.asset(AppImage.carImg),
                                label: 'Ride',
                                context: context),
                            buildCategoryColumn(
                                image: Image.asset(AppImage.carPreImg),
                                label: 'Rental',
                                context: context),
                            buildCategoryColumn(
                                icon: Icons.calendar_month_outlined,
                                label: 'Reserve',
                                context: context),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        carsouselSlider(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget carsouselSlider() {
  final List<String> imageList = [AppImage.rides, AppImage.rides];
  return CarouselSlider(
    options: CarouselOptions(
      enlargeCenterPage: true,
      autoPlay: true,
      aspectRatio: 16 / 9,
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: true,
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      viewportFraction: 1,
    ),
    items: imageList
        .map((item) => Center(
              child: Image.asset(item, fit: BoxFit.cover, width: 1000),
            ))
        .toList(),
  );
}

Widget searchField(bool isEnabled) {
  return GestureDetector(
    onTap: () => isEnabled ? {} : Get.to(() => const SearchScreen()),
    child: TextFormField(
      enabled: isEnabled,
      // controller: signUpController.nameController,
      decoration: InputDecoration(
        fillColor: Colors.amber,
        // labelText: "Where to go?",
        hintText: "Where to go?",
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            // borderRadius: BorderRadius.circular(12),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        hintStyle: const TextStyle(
            // fontStyle: fontStyle,
            fontWeight: FontWeight.bold,
            // fontFamily: fontFamily,
            fontSize: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.orange),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.arrow_circle_right_outlined),
      ),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.name,
      // validator: (value) {
      // if (value!.isEmpty) {
      //   signUpController.buttonController.reset();
      //   return AppString.pleaseEnterName;
      // } else {
      //   return null;
      // }
      // },
    ),
  );
}

Widget buildCategoryColumn(
    {Image? image,
    IconData? icon,
    required String label,
    required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      debugPrint("label $label");
      if (label == "Reserve") {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        ).then((selectedDate) {
          // After selecting the date, display the time picker.
          if (selectedDate != null) {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            ).then((selectedTime) {
              // Handle the selected date and time here.
              if (selectedTime != null) {
                DateTime selectedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                debugPrint(selectedDateTime
                    .toString()); // You can use the selectedDateTime as needed.
                Get.snackbar(
                    "Selected Date & Time", selectedDateTime.toString(),
                    snackPosition: SnackPosition.BOTTOM);
              }
            });
          }
        });
      } else {
        Get.to(() => const MapScreen());
      }
    },
    child: Column(
      children: [
        Container(
          height: 80,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: image ?? Icon(icon, size: 35)),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
