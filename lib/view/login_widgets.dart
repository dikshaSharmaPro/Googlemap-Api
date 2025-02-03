import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../config/app_color.dart';
import '../config/app_image.dart';

Widget bgImage(BuildContext context) {
  return Container(
    color: AppColor.loginBgImageColor,
    // height: Get.height / 4.5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            AppImage.loginImage,
            // height: Get.height / 5.8,
          ),
        ),
      ],
    ),
  );
}

Widget mobileNumber(TextEditingController mobileController) {
  return IntlPhoneField(
    autofocus: true,
    cursorColor: Colors.orange,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    validator: (phone) {
      if (phone!.number.length < 10) {
        return "Mobile number should be of 10 digits";
      } else {
        return null;
      }
    },
    controller: mobileController,
    decoration: const InputDecoration(
      labelText: "Mobile Number",
      border: OutlineInputBorder(
        borderSide: BorderSide(),
      ),
    ),
    initialCountryCode: 'IN',
    onCountryChanged: (value) {
      debugPrint(value.dialCode);
    },
    onChanged: (phone) {
      debugPrint(phone.completeNumber);
    },
  );
}
