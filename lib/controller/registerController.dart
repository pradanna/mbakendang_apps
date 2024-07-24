import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';

class RegisterController extends GetxController {
  var username = ''.obs;
  var fullName = ''.obs;
  var address = ''.obs;
  var phoneNumber = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var isLoading = false.obs;

  Dio _dio = Dio();

  void register() async {
    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    isLoading(true);

    try {
      final response = await _dio.post(
        baseURL+'/api/register',
        data: {
          'username': username.value,
          'nama': fullName.value,
          'password': password.value,
          'password_confirmation ': confirmPassword.value,
          'alamat': address.value,
          'no_hp': phoneNumber.value,
          'role' : "user"
        },
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Registration successful');
        Get.offAllNamed('/login');
      } else {
        Get.snackbar('Error', 'Registration failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
