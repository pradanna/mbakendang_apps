import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbakendang/Components/helper.dart';
import 'controller/paymentController.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Paymentcontroller controller = Get.put(Paymentcontroller());
    final id = Get.arguments['id'];

    controller.getPaymentData(id);

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
              child: Obx(() => controller.isloading.value ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  print("item count " +controller.items.length.toString());

                  return ListTile(
                    title: Text(item['barangs_all']['nama'].toString()),
                    subtitle: Text(
                        formatRupiah(item['harga']) +"x"+ item['qty'].toString()),
                    trailing: Text(
                        formatRupiah(item['harga'] * item['qty'])),
                  );
                },
              )),
            ),
            Divider(),
            Obx(() => controller.isloading.value ? Center(child: CircularProgressIndicator(),) :Text(
              'Total: '+formatRupiah(int.parse(controller.total.value)).toString(),
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
              child: Obx(() =>
                controller.loadingSendProff.value ? Center(child: CircularProgressIndicator(),) :  ElevatedButton(
                  onPressed: () => controller.sendPaymentProof(id.toString()),
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
            ),
          ],
        ),
      ),
    );
  }
}
