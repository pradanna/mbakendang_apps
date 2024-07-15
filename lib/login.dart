import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/loginController.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
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
          // Bottom sheet for login form
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
                          'Login',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Masukan Username dan Password',
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          Icons.account_circle,
                          'Username',
                          onChanged: (value) => controller.username.value = value,
                          borderColor: Colors.black, // Change border color here
                        ),
                        SizedBox(height: 20),
                        buildTextFieldWithIcon(
                          Icons.lock,
                          'Password',
                          onChanged: (value) => controller.password.value = value,
                          obscureText: true,
                          borderColor: Colors.black, // Change border color here
                        ),
                        SizedBox(height: 50),
                        Obx(() => controller.isLoading.value
                            ? CircularProgressIndicator()
                            : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.login,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.lightBlue,
                            ),
                            child: Text('Login'),
                          ),
                        )),
                        SizedBox(height: 20,),
                        InkWell(onTap: (){
                          Get.toNamed("/register");
                        },child: Text("Belum punya akun? Daftar Sekarang", style: TextStyle(color: Colors.blue),),)
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
        Color borderColor = Colors.black, // Default border color
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
            borderSide: BorderSide(color: borderColor), // Border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor), // Focused border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor.withOpacity(0.2)), // Enabled border color
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black), // Error border color
          ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}
