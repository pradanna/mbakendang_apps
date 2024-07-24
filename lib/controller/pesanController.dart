import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';

class PesanController extends GetxController {
  var userName = ''.obs;
  var phoneNumber = ''.obs;
  var isLoading = false.obs, isLoadingBarang = false.obs;
  var selectedCategory = 0.obs;
  final Dio _dio = Dio();
  final GetStorage box = GetStorage();
  var profileData = {}.obs;
  var items = <dynamic>[].obs;

  var categories = ['Semua','Makanan', 'Minuman', 'Lain-lain'].obs;

  var cartItemsCount = 0.obs;

  void addToCart(String item) {
    cartItemsCount.value++;
  }

  Future<void> getProfile() async {
    final token = await box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoading(true);
    try {
      final response = await _dio.get(
        baseURL+'/api/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Store profile data
        profileData.value = response.data;
      } else {
        Get.snackbar('Error', 'Failed to fetch profile data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching profile data');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getItems(param) async {
    final token = await box.read('token');
    if (token == null) {
      Get.snackbar('Error', 'No token found');
      return;
    }

    isLoadingBarang(true);
    try {
      final response = await _dio.get(
        baseURL+'/api/barangs?q='+param,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );


      if (response.statusCode == 200) {
        // Store profile data
        items.value = response.data;
      } else {
        Get.snackbar('Error', 'Failed to fetch Items data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching Items data');
    } finally {
      isLoadingBarang(false);
    }
  }
}
