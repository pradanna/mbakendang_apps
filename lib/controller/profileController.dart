import 'package:get/get.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var fullName = ''.obs;
  var address = ''.obs;
  var phoneNumber = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() {
    // Contoh data profil pengguna
    email.value = 'example@gmail.com';
    fullName.value = 'John Doe';
    address.value = 'Jl. Sudirman No.1, Jakarta';
    phoneNumber.value = '081234567890';
  }
}
