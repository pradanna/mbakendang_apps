import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/profileController.dart';

class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => Text(
              controller.email.value,
              style: TextStyle(fontSize: 16),
            )),
            SizedBox(height: 20),
            Text(
              'Nama Lengkap:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => Text(
              controller.fullName.value,
              style: TextStyle(fontSize: 16),
            )),
            SizedBox(height: 20),
            Text(
              'Alamat:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => Text(
              controller.address.value,
              style: TextStyle(fontSize: 16),
            )),
            SizedBox(height: 20),
            Text(
              'No HP:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Obx(() => Text(
              controller.phoneNumber.value,
              style: TextStyle(fontSize: 16),
            )),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan logika logout di sini
                  print('Logout pressed');
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
