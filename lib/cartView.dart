import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbakendang/Components/cartItem.dart';
import 'package:mbakendang/Components/helper.dart';
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
                    imageUrl: "http://192.168.18.9:8000" + item['barangs']['image'],
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
                        controller.checkout();
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
