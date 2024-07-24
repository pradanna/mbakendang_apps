import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbakendang/Components/cartItem.dart';
import 'package:mbakendang/Components/helper.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';
import 'controller/cartController.dart';

class CartView extends StatelessWidget {
  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Text('Keranjang Anda kosong'),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  var item = controller.cartItems[index];
                   return CartItem(
                    imageUrl: baseURL + item['barangs']['image'],
                    name: item['barangs']['nama'],
                    qty: item['qty'],
                    total: formatRupiah(item['barangs']['harga'] * item['qty']), onRemove: () {
                      controller.removeItemFromCart(item['id']);
                   },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() =>
                     Text(
                      'Total Harga: '+ formatRupiah(controller.totalPrice.value),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Logic for placing the order goes here
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Pilih Tanggal dan Waktu'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() => ListTile(
                                    title: Text('Tanggal: ${controller.selectedDate.value.toLocal()}'.split(' ')[0]),
                                    trailing: Icon(Icons.calendar_today),
                                    onTap: () => controller.selectDate(context),
                                  )),
                                  Obx(() => ListTile(
                                    title: Text('Waktu: ${controller.selectedTime.value.format(context)}'),
                                    trailing: Icon(Icons.access_time),
                                    onTap: () => controller.selectTime(context),
                                  )),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Batal'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    controller.checkout();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightBlue,
                      ),
                      child: Text('Pesan Sekarang'),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
