import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkLoginApi {
  static String baseURL = 'https://cba.albrandz.in/cba/api/passenger/';
  static Future<bool> sendOTP(String mobileNumber) async {
    debugPrint("mobileNumber $mobileNumber");
    String url = '${baseURL}login/otp';

    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> data = {'mobile': mobileNumber};

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final String? message = jsonResponse['response']['status'];
        if (message! == "success") {
          debugPrint('Response: ${response.body}');
          return true;
        } else {
          return false;
        }
      } else {
        debugPrint('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Exception: $error');
      return false;
    }
  }

  static Future<bool> resendUserOTP(String mobileNumber) async {
    debugPrint("mobileNumber $mobileNumber");
    String url = '${baseURL}resend/otp';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> data = {'mobile': mobileNumber};

    try {
      final http.Response response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final String? message = jsonResponse['response']['status'];
        if (message! == "success") {
          debugPrint('Response: ${response.body}');
          return true;
        } else {
          return false;
        }
      } else {
        debugPrint('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Exception: $error');
      return false;
    }
  }

  static Future<bool> verifyUserOTP(
      String mobileNumber, String enteredOTP) async {
    String url = '${baseURL}verify/otp';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, dynamic> data = {
      'mobile': mobileNumber,
      'otp': enteredOTP
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final String? message = jsonResponse['response']['status'];
        if (message! == "success") {
          debugPrint('Response: ${response.body}');
          return true;
        } else {
          return false;
        }
      } else {
        debugPrint('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      debugPrint('Exception: $error');
      return false;
    }
  }
}
