import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var isAddingToCart = false.obs;
  final Dio _dio = Dio();
  final GetStorage storage = GetStorage();
  var isLoadingCart = false.obs;
  var totalQuantity = 0.obs;
  var totalPrice = 0.obs;
  var cartItems = <dynamic>[].obs;
var cartItemsCount = 0.obs;

  Future<void> addToCart(int idbarang, int qty, int harga) async {
    final token = await storage.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isAddingToCart(true);
    try {
      final response = await _dio.post(
        'http://192.168.18.9:8000/api/cart',
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
        'http://192.168.18.9:8000/api/cart',
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
        'http://192.168.18.9:8000/api/cart/$id',
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

    DateTime now = DateTime.now();

    // Mendapatkan bagian tanggal saja (tahun, bulan, hari)
    String date = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    // Mendapatkan bagian waktu saja (jam, menit, detik)
    String time = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';


    isAddingToCart(true);
    try {
      final response = await _dio.post(
        'http://192.168.18.9:8000/api/cart/checkout',
      data: {
          'tanggal': date ,
              'jam' : time
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
      Get.toNamed("/payment");
    }
  }
}
