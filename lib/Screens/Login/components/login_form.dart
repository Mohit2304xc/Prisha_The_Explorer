import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prishathe/Controller/LoginController.dart';
import 'package:http/http.dart' as http;
import 'package:prishathe/Widgets/Validator/Validator.dart';
import '../../../Widgets/API_Connection/API_connection.dart';
import '../../../Widgets/Animation/FullScreenLoader.dart';
import '../../../Widgets/network/NetworkManger.dart';
import '../../../Widgets/snackbar/Snackbar.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import '../ForgotPassword.dart';
import '../login_screen.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
            validator: (value)=>Validators.validateEmail(value),
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              validator: (value)=> Validators.validatePassword(value),
              controller: controller.password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: Colors.orangeAccent,
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.rememberMe.value =
                            !controller.rememberMe.value;
                      },
                    ),
                  ),
                  const Text("Remember Me",style: TextStyle(color: Colors.black)),
                ],
              ),
              SizedBox(width: 34,),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPassword());
                  },
                  child: const Text("Forgot Password",style: TextStyle(color: Colors.black),),
                ),
              )
            ],
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              controller.loginUser();
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}



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
        }
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      SnackBars.ErrorSnackBar(title: "Oh Snap!", message: e.toString());
    }
  }
}
