import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  var username = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;

  final Dio _dio = Dio();
  final GetStorage box = GetStorage();

  Future<void> login() async {
    isLoading(true);
    try {
      final response = await _dio.post(
        'http://192.168.18.9:8000/api/login',
        data: {
          'username': username.value,
          'password': password.value,
        },
      );

      if (response.statusCode == 200) {
        // Simpan token ke GetStorage
        await box.write('token', response.data['data']['token']);
        // Handle successful login
        Get.snackbar('Success', 'Login successful');
        // Navigate to home or dashboard
        Get.offAllNamed('/home');
      } else {
        // Handle unsuccessful login
        Get.snackbar('Error', 'Login failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }

  // Fungsi untuk mendapatkan token dari GetStorage
  String?  getToken()  {
    return box.read('token');
  }
}
