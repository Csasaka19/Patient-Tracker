import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/configs/constants.dart';
import 'package:patient_tracker/customs/custombutton.dart';
import 'package:patient_tracker/customs/customtext.dart';
import 'package:patient_tracker/customs/customtextfield.dart';
import 'package:patient_tracker/customs/square_tile.dart';
import 'package:http/http.dart' as http;

TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController firstnameController = TextEditingController();
TextEditingController lastnameController = TextEditingController();

class Registration extends StatelessWidget {
  Registration({Key? key}) : super(key: key);

  void registerButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
        
                // logo
                const Image(
                  image: AssetImage('assets/logos/healthy.png'),
                  width: 100,
                  height: 100,
                ),
        
                const SizedBox(height: 30),
        
                // welcome back!
                const CustomText(
                  label: "Hello! Join Us",
                  fontSize: 30,
                  labelColor: appbartextColor,
                ),
        
                const SizedBox(height: 25),
        
                // username textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        label: "Username",
                        labelColor: appbartextColor,
                        fontSize: 16),
                    const SizedBox(width: 15),
                    CustomTextField(
                      userFieldController: userNameController,
                      icon: Icons.person_2_sharp,
                      hint: 'Username',
                    ),
                  ],
                ),
        
                const SizedBox(height: 15),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        label: "First Name",
                        labelColor: appbartextColor,
                        fontSize: 16),
                    const SizedBox(width: 10),
                    CustomTextField(
                      userFieldController: firstnameController,
                      icon: Icons.person_4_outlined,
                      hint: 'First Name',
                    ),
                  ],
                ),
        
                const SizedBox(height: 15),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        label: "Last Name",
                        labelColor: appbartextColor,
                        fontSize: 16),
                    const SizedBox(width: 10),
                    CustomTextField(
                      userFieldController: lastnameController,
                      icon: Icons.person_4_outlined,
                      hint: 'Last Name',
                    ),
                  ],
                ),
        
                const SizedBox(height: 15),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        label: "Email",
                        labelColor: appbartextColor,
                        fontSize: 16),
                    const SizedBox(width: 55),
                    CustomTextField(
                      userFieldController: emailController,
                      icon: Icons.mark_email_unread_outlined,
                      hint: 'Email',
                    ),
                  ],
                ),
        
                const SizedBox(height: 15),
        
                // password textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        label: "Password",
                        labelColor: appbartextColor,
                        fontSize: 16),
                    const SizedBox(width: 10),
                    CustomTextField(
                      userFieldController: passwordController,
                      icon: Icons.lock_outline_sharp,
                      isPassword: true,
                      hint: 'Password',
                    ),
                  ],
                ),
        
                const SizedBox(height: 15),
        
                // Confirm password textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                        label: "Confirm",
                        labelColor: appbartextColor,
                        fontSize: 16),
                    const SizedBox(width: 20),
                    CustomTextField(
                      userFieldController: confirmController,
                      icon: Icons.lock_outline_sharp,
                      isPassword: true,
                      hint: 'Confirm Password',
                    ),
                  ],
                ),
        
                const SizedBox(height: 25),
        
                // Registration button
                customButton(
                  labelButton: 'Register',
                  action: () => remoteSignup(),
                  labelColor: primaryColor,
                ),
        
                const SizedBox(height: 20),
        
                // Alternative login options
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: appbartextColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: CustomText(
                            label: "Or Register with",
                            labelColor: appbartextColor,
                            fontSize: 16),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: appbartextColor,
                        ),
                      ),
                    ],
                  ),
                ),
        
                const SizedBox(height: 30),
        
                //  Google + Fit sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button
                    SquareTile(imagePath: 'assets/images/google.png'),
        
                    SizedBox(width: 25),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> remoteSignup() async {
    http.Response response;
    response = await http.post(
        Uri.parse("http://acs314flutter.xyz/Patient-tracker/signup.php"),
        body: {
          "username": userNameController.text.trim(),
          "email": emailController.text.trim(),
          "first_name": firstnameController.text.trim(),
          "second_name": lastnameController.text.trim(),
          "password": passwordController.text.trim(),
        });

    if (response.body == "success") {
      var serverResponse = json.decode(response.body);
      int signupStatus = serverResponse['success'];
      if (signupStatus == 1) {
        Get.snackbar("Success", "Registration successful", backgroundColor: pinkColor, colorText: appbartextColor);
        Get.back();
      } else {
        Get.snackbar("Error", "Registration failed", backgroundColor: pinkColor, colorText: appbartextColor);
      }
    }
  }

  void gotoLogin() {
    Get.toNamed('/login');
  }
}
