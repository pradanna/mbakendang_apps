import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mbakendang/Components/helper.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';

class CartController extends GetxController {
  var isAddingToCart = false.obs;
  final Dio _dio = Dio();
  final GetStorage storage = GetStorage();
  var isLoadingCart = false.obs;
  var totalQuantity = 0.obs;
  var totalPrice = 0.obs;
  var cartItems = <dynamic>[].obs;
var cartItemsCount = 0.obs;
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  Future<void> addToCart(int idbarang, int qty, int harga) async {
    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isAddingToCart(true);
    try {
      final response = await _dio.post(
        baseURL+'/api/cart',
        data: {
          'barang_id': idbarang,
          'qty': qty,
          'harga': harga,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Item added to cart successfully');
      } else {
        Get.snackbar('Error', 'Failed to add item to cart');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while adding item to cart');
    } finally {
      isAddingToCart(false);
      getCartItems();
    }
  }

  Future<void> getCartItems() async {
    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoadingCart(true);
    try {
      final response = await _dio.get(
        baseURL+'/api/cart',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        cartItems.value = response.data.map((item) {
          return {
            'id': item['id'],
            'nama': item['nama'],
            'harga': num.parse(item['harga'].toString()), // Ensure this is num
            'qty': num.parse(item['qty'].toString()), // Ensure this is num
            'image': item['image'],
            'barangs': item['barangs'],
            'total': item['total'],
          };
        }).toList();

        // Calculate total quantity
        totalQuantity.value = cartItems.fold(0, (sum, item) => (sum +  item['qty']).toInt());
        totalPrice.value = cartItems.fold(0, (sum, item) => (sum +  item['total']).toInt());
        print(totalQuantity);
      } else {
        Get.snackbar('Error', 'Failed to fetch cart data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching cart data');
    } finally {
      isLoadingCart(false);
    }
  }

  Future<void> removeItemFromCart(int id) async {
    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    try {
      final response = await _dio.delete(
        baseURL+'/api/cart/$id/delete',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        cartItems.removeWhere((item) => item['id'] == id);
        totalQuantity.value = cartItems.fold(0, (sum, item) => (sum +  item['qty']).toInt());
        totalPrice.value = cartItems.fold(0, (sum, item) => (sum +  item['total']).toInt());
        Get.snackbar('Success', 'Item removed from cart');
      } else {
        Get.snackbar('Error', 'Failed to remove item from cart');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while removing item from cart');
    }
  }

  Future<void> checkout() async {
    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isAddingToCart(true);
    try {
      final response = await _dio.post(
        baseURL+'/api/cart/checkout',
      data: {
          'tanggal': formatDate(selectedDate.value),
              'jam' : '${selectedTime.value.hour.toString().padLeft(2, '0')}:${selectedTime.value.minute.toString().padLeft(2, '0')}:00'

      },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',

          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Item added to cart successfully');
      } else {
        Get.snackbar('Error', 'Failed to add item to cart');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while adding item to cart');
    } finally {
      isAddingToCart(false);
      Get.toNamed("/home");
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      print(picked.toString());
      print(formatDate(selectedDate.value));
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
    );
    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
      print(picked.toString());
      print('${selectedTime.value.hour.toString().padLeft(2, '0')}:${selectedTime.value.minute.toString().padLeft(2, '0')}:00');

    }
  }
}
