import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/ForgotPasswordController.dart';
import '../../Widgets/Validator/Validator.dart';
import '../../constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Forgot Password",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Enter Your Email Address",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 16,
              ),
              Form(
                key: passwordController.forgotPasswordFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: passwordController.email,
                      validator: Validators.validateEmail,
                      decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email_outlined)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController.password,
                        validator: (value) => Validators.validatePassword(value),
                        decoration: const InputDecoration(
                            labelText: "New Password",
                            prefixIcon: Icon(Icons.password)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    passwordController.passwordResetDialog();
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
