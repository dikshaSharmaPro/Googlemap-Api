import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map/network/login_api.dart';

class LoginController extends GetxController {
  RxBool sendOtpInProgress = false.obs;
  RxInt countDownTimer = 120.obs;
  Timer? _timer;
  RxBool resendOTPEnabled = false.obs;
  RxBool verifyingOTP = false.obs;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // @override
  // void onInit() {
  //   startCountDown();
  //   super.onInit();
  // }

  void startCountDown() {
    _timer?.cancel(); // Cancel any existing timer before starting a new one
    countDownTimer.value = 120; // Reset the countdown timer to 120 seconds

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDownTimer.value > 0) {
        countDownTimer.value--;
      } else {
        timer.cancel();
        resendOTPEnabled.value = true;
      }
    });
  }

  Future<bool> requestOtp(String mobileNo) async {
    bool response = await NetworkLoginApi.sendOTP(mobileNo);
    debugPrint('response $response');
    if (response) {
      return true;
    } else {
      sendOtpInProgress.value = false;
      return false;
    }
  }

  Future<bool> resendOtp(String mobileNo) async {
    bool response = await NetworkLoginApi.resendUserOTP(mobileNo);
    debugPrint('response $response');
    if (response) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyOtp(String mobileNo, String otp) async {
    bool response = await NetworkLoginApi.verifyUserOTP(mobileNo, otp);
    debugPrint('response $response');
    if (response) {
      return true;
    } else {
      return false;
    }
  }
}
