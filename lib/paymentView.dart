import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'controller/paymentController.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Paymentcontroller controller = Get.put(Paymentcontroller());

    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Pembayaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text(
                        'Rp${item['price']} x ${item['quantity']}'),
                    trailing: Text(
                        'Rp${item['price'] * item['quantity']}'),
                  );
                },
              )),
            ),
            Divider(),
            Obx(() => Text(
              'Total: Rp${controller.amount.value}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )),
            SizedBox(height: 20),
            Text(
              'Upload Bukti Transfer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Obx(() => controller.transferImagePath.value == ''
                ? Text('No image selected.')
                : Image.file(
              File(controller.transferImagePath.value),
              height: 200,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => controller.pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera),
                  label: Text('Kamera'),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => controller.pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text('Galeri'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: 1.sw,
              child: ElevatedButton(
                onPressed: () => controller.makePayment(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  foregroundColor: Colors.white, // Text color
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Kirim Pembayaran',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
