import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';

import 'Components/helper.dart';
import 'Components/menuItem.dart';
import 'controller/cartController.dart';

class MenuItemDetailPage extends StatelessWidget {
  final Map<String, dynamic> menuItem;

  MenuItemDetailPage({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.put(CartController());
    final qty = 1.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(menuItem['nama']),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar besar di atas
          Image.network(
            baseURL+ menuItem['image'],
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          // Nama menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              menuItem['nama'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          // Harga menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              formatRupiah(menuItem['harga']),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.green),
            ),
          ),
          SizedBox(height: 20),
          // Pengaturan quantity
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text('Quantity:', style: TextStyle(fontSize: 18)),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    if (qty.value > 1) {
                      qty.value--;
                    }
                  },
                ),
                Obx(() => Text(qty.value.toString(), style: TextStyle(fontSize: 18))),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    qty.value++;
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Tombol untuk memasukkan ke keranjang
           Obx(() => cartController.isLoadingCart.value ? Center(child: CircularProgressIndicator(),) :
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                   await cartController.addToCart(menuItem['id'], qty.value, menuItem['harga']);
                   Get.offAndToNamed("/home");
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: Text('Add to Cart', style: TextStyle(fontSize: 18)),
                ),
              ),
                       ),
           ),
        ],
      ),
    );
  }
}
