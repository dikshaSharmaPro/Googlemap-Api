import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/view/login_widgets.dart' as lw;
import 'package:map/view/otp_verify_screen.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final String countryCode = "91";
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController mobileController = TextEditingController();
    final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: loginFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                lw.bgImage(context),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: Get.height / 19,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle
                                ?.color),
                      ),
                      SizedBox(height: Get.height / 30),
                      lw.mobileNumber(mobileController),
                      SizedBox(height: Get.height / 43),
                      Obx(() {
                        if (loginController.sendOtpInProgress.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return InkWell(
                            onTap: () async {
                              debugPrint("button pressed");
                              if (loginFormKey.currentState!.validate() &&
                                  mobileController.text.length == 10) {
                                loginController.sendOtpInProgress.value = true;
                                bool responseBool =
                                    await loginController.requestOtp(
                                        '+$countryCode${mobileController.text}');
                                debugPrint("responseBool $responseBool");
                                if (responseBool) {
                                  loginController.sendOtpInProgress.value =
                                      false;

                                  Get.to(() => OtpVerifyScreen(
                                      enteredMobileNumber:
                                          countryCode + mobileController.text));
                                } else {
                                  Get.snackbar("Something went wrong",
                                      "Please Try Again");
                                }
                              } else {
                                debugPrint("else hitted");
                              }
                            },
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
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
                                "Login",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          );
                        }
                      }),
                      // SizedBox(height: Get.height / 43),
                    ],
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
