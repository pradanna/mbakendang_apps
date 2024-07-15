import 'package:get/get.dart';

class HistoryController extends GetxController {
  var orderHistory = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  void fetchOrderHistory() {
    // Contoh data riwayat pesanan
    var dummyHistory = [
      {
        'orderId': '12345',
        'items': [
          {'name': 'Kopi Latte', 'quantity': 1, 'price': 25000},
          {'name': 'Kue Brownies', 'quantity': 2, 'price': 15000},
        ],
        'totalPrice': 55000,
        'date': '2024-06-24 10:30:00'
      },
      {
        'orderId': '67890',
        'items': [
          {'name': 'Espresso', 'quantity': 2, 'price': 20000},
          {'name': 'Croissant', 'quantity': 1, 'price': 10000},
        ],
        'totalPrice': 50000,
        'date': '2024-06-23 08:15:00'
      },
    ];

    orderHistory.value = dummyHistory;
  }
}
