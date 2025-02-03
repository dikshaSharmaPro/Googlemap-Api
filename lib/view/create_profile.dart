import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/controller/profile_controller.dart';
import 'package:map/view/login_widgets.dart';
import 'package:map/view/profile_submitted.dart';

// import '../custom/custom_widget.dart';

class CreateUserProfile extends StatelessWidget {
  CreateUserProfile({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: profileFormKey,
          child: Column(
            children: [
              bgImage(context),
              Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: Get.height / 19,
                ),
                child: Column(
                  children: [
                    signInText(context),
                    SizedBox(height: Get.height / 23),
                    nameField(nameController),
                    SizedBox(height: Get.height / 43),
                    emailField(emailController),
                    SizedBox(height: Get.height / 43),
                    const Row(
                      children: [
                        DateOfBirthSelector(),
                        SizedBox(width: 20),
                        GenderDropdown()
                      ],
                    ),
                    SizedBox(height: Get.height / 43),
                    pinField(pinController),
                    SizedBox(height: Get.height / 43),
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                            value: profileController.isTNCSelected.value,
                            onChanged: (bool? value) {
                              profileController.isTNCSelected.value =
                                  !profileController.isTNCSelected.value;
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              profileController.isTNCSelected.value =
                                  !profileController.isTNCSelected.value;
                            },
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "I've reviewed and agree to the \n",
                                  ),
                                  TextSpan(
                                    text: 'Terms of use ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: '& aknowledge the \n',
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Get.height / 43),
                    GestureDetector(
                      onTap: () {
                        if (profileFormKey.currentState!.validate() &&
                            profileController.isTNCSelected.value &&
                            selectedDate != null &&
                            selectedGender != null) {
                          Get.offAll(() => const ProfileSubmitted());
                        } else {
                          Get.snackbar("Fill Form", "Complete the form");
                        }
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
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
                                colors: [
                                  Color(0xfffbb448),
                                  Color(0xfff7892b)
                                ])),
                        child: const Text(
                          "Submit",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: Get.height / 43),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget signInText(context) {
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    // mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "Create Profile",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).appBarTheme.titleTextStyle?.color),
      ),
      const SizedBox(height: 6),
      Text(
        "Please enter below details to continue.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          // fontFamily: FontFamily.mulishMedium,
          color: Theme.of(context).textTheme.titleMedium?.color,
        ),
      )
    ],
  );
}

Widget nameField(TextEditingController nameController) {
  return TextFormField(
    controller: nameController,
    decoration: InputDecoration(
      fillColor: Colors.amber,
      labelText: "Enter Name",
      hintText: "Enter Name",
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(10),
      prefixIcon: const Icon(Icons.person),
    ),
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    keyboardType: TextInputType.name,
    validator: (value) {
      if (value!.isEmpty) {
        return "Please Enter Name";
      } else {
        return null;
      }
    },
  );
}

Widget emailField(TextEditingController emailController) {
  return TextFormField(
    controller: emailController,
    decoration: InputDecoration(
      fillColor: Colors.amber,
      labelText: "Enter Email",
      hintText: "abc@example.com",
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      hintStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(10),
      prefixIcon: const Icon(Icons.mail),
    ),
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    keyboardType: TextInputType.name,
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter email";
      } else {
        return null;
      }
    },
  );
}

Widget pinField(TextEditingController pinController) {
  return TextFormField(
    obscureText: true,
    controller: pinController,
    decoration: InputDecoration(
      fillColor: Colors.amber,
      labelText: "Pin (6 Digit)",
      hintText: "******",
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      hintStyle: const TextStyle(
          // fontStyle: fontStyle,
          fontWeight: FontWeight.bold,
          // fontFamily: fontFamily,
          fontSize: 12),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange),
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(10),
      prefixIcon: const Icon(Icons.password),
      // prefix: prefix,
      // suffix: suffix,
      // suffixIcon: suffixIcon,
    ),
    style: const TextStyle(
      // fontFamily: FontFamily.mulishMedium,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      // color: AppColor.placeholderDarkMode,
    ),
    keyboardType: TextInputType.number,
    maxLength: 6,
    validator: (value) {
      if (value!.isEmpty) {
        return "Please Enter Pin";
      } else if (value.length < 6) {
        return "Pin Should be 6 digit long";
      } else {
        return null;
      }
    },
  );
}

String? selectedGender;

class GenderDropdown extends StatefulWidget {
  const GenderDropdown({super.key});

  @override
  GenderDropdownState createState() => GenderDropdownState();
}

class GenderDropdownState extends State<GenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
          // color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange),
        ),
        child: Container(
          height: 45,
          padding: const EdgeInsets.all(10),
          child: DropdownButton<String>(
            value: selectedGender,
            hint: const Text('Select Gender'),
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue;
              });
            },
            items: <String>['Male', 'Female', 'Other']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

DateTime? selectedDate;

class DateOfBirthSelector extends StatefulWidget {
  const DateOfBirthSelector({super.key});

  @override
  DateOfBirthSelectorState createState() => DateOfBirthSelectorState();
}

class DateOfBirthSelectorState extends State<DateOfBirthSelector> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                selectedDate != null
                    ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                    : "Select DOB",
              ),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }
}
