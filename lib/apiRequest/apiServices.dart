import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

const String host = "http://192.168.18.9:8000";
class ApiService {
  GetStorage box = GetStorage();

  Future<Response> login(String email, String password) async {
    var formData = FormData.fromMap({'email': email, 'password': password});

    try {
      Response response = await Dio().post(
          'https://carbranding.genossys.com/driver/auth/sign-in',
          data: formData,
          options: Options(headers: {'Accept': 'application/json'})
          // Pastikan URL ini benar
          );

      await box.write("token", response.data['data']['access_token']);
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
