import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Screens/Login/login_screen.dart';
import '../Widgets/API_Connection/API_connection.dart';
import '../Widgets/Animation/FullScreenLoader.dart';
import '../Widgets/network/NetworkManger.dart';
import '../Widgets/snackbar/Snackbar.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  passwordResetDialog() async {
    try {
      FullScreenLoader.openLoadingDialog("Processing your request...",
          "assets/images/success/141594-animation-of-docer.json");
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (!forgotPasswordFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      var res = await http.post(
        Uri.parse(API.forgotPassword),
        body: {
          'email': email.text.trim(),
          'password': password.text.trim(),
        },
      );
      print(res);
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        print(response);
        if (response['PasswordUpdated'] == true) {
          SnackBars.SuccessSnackBar(
              title: 'Congratulations',
              message: "Your password has been changed successfully");
          Future.delayed(
            const Duration(milliseconds: 2000),
                () {
              Get.to(() => const LoginScreen());
            },
          );
        } else {
          SnackBars.ErrorSnackBar(
              title: 'Invalid!',
              message: "Please enter correct login details or Signup");
          FullScreenLoader.stopLoading();
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
