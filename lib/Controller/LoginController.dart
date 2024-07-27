import 'dart:convert';
import 'package:prishathe/Model/Usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:prishathe/Screens/HomePage/HomePage.dart';
import '../Widgets/API_Connection/API_connection.dart';
import '../Widgets/Animation/FullScreenLoader.dart';
import '../Widgets/Services/SharedReferences.dart';
import '../Widgets/network/NetworkManger.dart';
import '../Widgets/snackbar/Snackbar.dart';
import 'UserController.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final userController = Get.put(UserController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeFields();
  }

  void initializeFields() async {
    final storedEmail = await SharedReferences.read('REMEMBER_ME_EMAIL');
    final storedPassword = await SharedReferences.read('REMEMBER_ME_PASSWORD');

    email.text = storedEmail ?? '';
    password.text = storedPassword ?? '';
  }

  loginUser() async {
    try {
      FullScreenLoader.openLoadingDialog(
        "Logging you in...",
        "assets/images/success/141594-animation-of-docer.json",
      );
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      if (loginFormKey.currentState != null && loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        SharedReferences.write('REMEMBER_ME_EMAIL', email.text.trim());
        SharedReferences.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          'email': email.text.trim(),
          'password': password.text.trim(),
        },
      );
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        if (response['success'] == true) {
          UserModel userInfo = UserModel.fromJson(response['userData']);
          print(userInfo.id);
          UserController.instance.user.value = userInfo;
          print(UserController.instance.user.value);
          await SharedReferences.saveUser(userInfo);
          await SharedReferences.isFirstTimeWrite(false);
          FullScreenLoader.stopLoading();
          Get.to(() => const HomePageScreen());
        } else {
          print(response['error']);
          SnackBars.ErrorSnackBar(
            title: 'Invalid!',
            message: "Please enter correct data",
          );
          FullScreenLoader.stopLoading();
        }
      }
    } catch (e) {
      print("${e.toString()}");
      FullScreenLoader.stopLoading();
    }
  }
}
