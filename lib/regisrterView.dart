import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/registerController.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            height: MediaQuery.of(context).size.height * 0.52,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo
          Positioned(
            top: 50,
            left: 30,
            child: Image.asset(
              'assets/images/logo.png',
              height: 50, // Adjust the height of the logo as needed
            ),
          ),
          // Bottom sheet for register form
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Please fill in the form to create an account',
                          style: TextStyle(fontSize: 12),
                        ),

                        SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          Icons.person,
                          'Full Name',
                          onChanged: (value) => controller.fullName.value = value,
                          borderColor: Colors.black,
                        ),
                        SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          Icons.home,
                          'Address',
                          onChanged: (value) => controller.address.value = value,
                          borderColor: Colors.black,
                        ),
                        SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          Icons.phone,
                          'Phone Number',
                          onChanged: (value) => controller.phoneNumber.value = value,
                          borderColor: Colors.black,
                        ),
                        SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          Icons.account_circle_rounded,
                          'Username',
                          onChanged: (value) => controller.username.value = value,
                          borderColor: Colors.black,
                        ),
                        SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          Icons.lock,
                          'Password',
                          onChanged: (value) => controller.password.value = value,
                          obscureText: true,
                          borderColor: Colors.black,
                        ),
                        SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          Icons.lock,
                          'Confirm Password',
                          onChanged: (value) => controller.confirmPassword.value = value,
                          obscureText: true,
                          borderColor: Colors.black,
                        ),
                        SizedBox(height: 50),
                        Obx(() => controller.isLoading.value
                            ? CircularProgressIndicator()
                            : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.register,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.lightBlue,
                            ),
                            child: Text('Register'),
                          ),
                        )),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () => Get.toNamed('/login'),
                          child: Text(
                            "Already have an account? Login",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTextFieldWithIcon(
      IconData iconData,
      String labelText, {
        ValueChanged<String>? onChanged,
        bool obscureText = false,
        Color borderColor = Colors.black,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor.withOpacity(0.2)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
