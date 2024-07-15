import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/historyController.dart';

class HistoryView extends StatelessWidget {
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Transaksi'),
      ),
      body: Obx(() {
        if (controller.orderHistory.isEmpty) {
          return Center(
            child: Text('Belum ada riwayat transaksi'),
          );
        }

        return ListView.builder(
          itemCount: controller.orderHistory.length,
          itemBuilder: (context, index) {
            var order = controller.orderHistory[index];
            return Card(
              margin: EdgeInsets.all(10),

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Order ID: ${order['orderId']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...order['items'].map<Widget>((item) {
                            return Text('${item['name']} x ${item['quantity']} - Rp ${item['price']}');
                          }).toList(),
                          SizedBox(height: 10),
                          Text('Total Harga: Rp ${order['totalPrice']}'),
                          Text('Tanggal: ${order['date']}'),
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status"),
                        ElevatedButton(onPressed: (){
                          Get.toNamed("/qr");
                        }, child: Text('Show QR')),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
