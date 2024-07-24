import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';

class HistoryController extends GetxController {
  var orderHistory = <Map<String, dynamic>>[].obs;
  final Dio _dio = Dio();
  final storage = GetStorage();
  final String apiUrl = baseURL+'/api/transaction';
  var isLoadingTerima = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory();
  }

  void fetchOrderHistory() async {
    try {
      final token = storage.read('token');
      final response = await _dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> history = List<Map<String, dynamic>>.from(response.data);
        orderHistory.value = history;
      } else {
        print('Failed to fetch order history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order history: $e');
    }
  }

  Future<void> terimaPesanan(String orderId) async {
    isLoadingTerima.value = true;

    try {
      final token = storage.read('token');

      final response = await _dio.post(
        '$baseURL/api/transaction/$orderId/terima',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Pesanan diterima dengan sukses',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        fetchOrderHistory();
      } else {
        Get.snackbar('Error', 'Gagal menerima pesanan: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }finally{
      isLoadingTerima.value = false;
    }
  }
}
