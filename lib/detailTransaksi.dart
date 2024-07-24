import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbakendang/Components/helper.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';
import 'package:mbakendang/controller/paymentController.dart';

import 'Components/TransaksiItemWidget.dart';

class TransaksiDetailView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Paymentcontroller controller = Get.put(Paymentcontroller());
    final id = Get.arguments['id'];

    // Memanggil fungsi untuk mendapatkan detail transaksi
    controller.getPaymentData(id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Transaksi'),
      ),
      body: Obx(() {
        if (controller.isloading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final transaksi = controller.dataTrans;
        if (transaksi.isEmpty) {
          return Center(child: Text('Transaksi tidak ditemukan'));
        }

        final items = transaksi['cart'] as List<dynamic>;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Order ID: ${transaksi['no_transaksi']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Tanggal Pesan: ' + formatDateTime(convertDateTime(transaksi['created_at'].toString())),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'permintaan tanggal kirim: ' + formatDateTime(transaksi['tanggal_pengiriman']),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Total Harga: ' + formatRupiah(transaksi['total']),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Daftar Barang:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return TransaksiItemWidget(
                      imageUrl: baseURL + item['barangs_all']['image'] ?? 'https://via.placeholder.com/60', // Placeholder jika tidak ada gambar
                      name: item['barangs_all']['nama'],
                      quantity: item['qty'],
                      price: item['harga'],
                      total: item['total'] ?? item['price'] * item['quantity'],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
