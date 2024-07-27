import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prishathe/Controller/Signupcontroller.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding / 2.5),
            child: TextFormField(
              controller: controller.firstName,
              decoration: const InputDecoration(
                hintText: "First Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2.5),
            child: TextFormField(
              controller: controller.lastName,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "Last Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2.5),
            child: TextFormField(
              controller: controller.email,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2.5),
            child: TextFormField(
              controller: controller.password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          // Row(
          //   children: [
          //     Obx(
          //       () => Checkbox(
          //         activeColor: Colors.orangeAccent,
          //         value: controller.privacyPolicy.value,
          //         onChanged: (value) {
          //           controller.privacyPolicy.value =
          //               !controller.privacyPolicy.value;
          //         },
          //       ),
          //     ),
          //     const Text("I agree to all Terms and Conditions",style: TextStyle(color: Colors.purpleAccent),),
          //   ],
          // ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              controller.signup();
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding / 2),
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
