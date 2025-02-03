import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:map/view/create_profile.dart';

import '../controller/login_controller.dart';
import 'login_widgets.dart';

class OtpVerifyScreen extends StatelessWidget {
  final String enteredMobileNumber;
  OtpVerifyScreen({super.key, required this.enteredMobileNumber});

  final GlobalKey<FormState> verifyScreenFormKey = GlobalKey<FormState>();
  final String countryCode = "91";
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController pinCodeController = TextEditingController();
    loginController.startCountDown();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Form(
          key: verifyScreenFormKey,
          child: SingleChildScrollView(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter OTP",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle
                                ?.color),
                      ),
                      SizedBox(height: Get.height / 50),
                      Text(
                        "Enter the 6-digit OTP sent you at +$enteredMobileNumber",
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .appBarTheme
                                .titleTextStyle
                                ?.color),
                      ),
                      SizedBox(height: Get.height / 50),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Center(
                          child: Text(
                            "Incorrect Number?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height / 50),
                      PinCodeFields(
                        controller: pinCodeController,
                        length: 6,
                        fieldBorderStyle: FieldBorderStyle.square,
                        responsive: false,
                        fieldHeight: Get.width * 0.09,
                        fieldWidth: Get.width * 0.09,
                        // borderWidth: 1.0,
                        activeBorderColor: Colors.orange,
                        activeBackgroundColor: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(10.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: false,
                        fieldBackgroundColor: Colors.black12,
                        borderColor: Colors.black38,
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        onComplete: (output) async {},
                      ),
                      SizedBox(height: Get.height / 43),
                      Obx(() {
                        if (loginController.verifyingOTP.value) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          return InkWell(
                            onTap: () async {
                              if (verifyScreenFormKey.currentState!
                                  .validate()) {
                                loginController.verifyingOTP.value = true;
                                bool isOTPVerified =
                                    await loginController.verifyOtp(
                                        '+$enteredMobileNumber',
                                        pinCodeController.text);
                                if (isOTPVerified) {
                                  loginController.verifyingOTP.value = false;

                                  Get.offAll(CreateUserProfile());
                                } else {
                                  loginController.verifyingOTP.value = false;

                                  Get.snackbar("Wrong OTP", "Please try again");
                                }
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
                                "Verify",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          );
                        }
                      }),
                      SizedBox(height: Get.height / 43),
                      Center(child: Obx(() {
                        if (loginController.resendOTPEnabled.value) {
                          return InkWell(
                            onTap: () async {
                              //resend otp again
                              bool isOTPResent = await loginController
                                  .resendOtp('+$enteredMobileNumber');
                              if (isOTPResent) {
                                loginController.startCountDown();
                                Get.snackbar(
                                    "OTP Sent", 'Please enter the OTP');
                              } else {
                                Get.snackbar("Something went wrong",
                                    'Please try again!!!');
                              }
                            },
                            child: const Text(
                              "Resend OTP Now",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Resend OTP in ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(loginController.countDownTimer.value
                                  .toString()),
                              const Text(
                                " seconds ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          );
                        }
                      })),
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
