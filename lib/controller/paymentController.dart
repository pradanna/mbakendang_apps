
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';

class Paymentcontroller extends GetxController {
  var amount = 0.0.obs;
  var items = <Map<String, dynamic>>[].obs;
  var dataTrans = <String, dynamic>{}.obs;
  var transferImagePath = ''.obs;
  final dio.Dio _dio = dio.Dio();
  final storage = GetStorage();
  var isloading = false.obs;
  var notrans = "".obs;
  var total = "".obs;
  var loadingSendProff = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Contoh barang yang sudah dipesan
  void getPaymentData(id) async {
    isloading.value = true;
    try {
      final token = storage.read('token');
      final response = await _dio.get(
        baseURL +"/api/transaction/"+id.toString(),
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(baseURL +"/api/transaction/"+id.toString());
      print('fetch detail transaksi: '+response.data.toString());

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(response.data['cart']);
        items.value = data;
        dataTrans.value = response.data;
        notrans.value = response.data["no_transaksi"];
        total.value =  response.data["total"].toString();

      } else {
        print('Failed to fetch order history: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching detail data : $e');
    }finally{
      isloading.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      transferImagePath.value = pickedFile.path;
    } else {
      Get.snackbar('Error', 'No image selected',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void makePayment() {
    // Logika untuk pembayaran
    if (transferImagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please upload proof of transfer',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    print("Pembayaran sebesar Rp${amount.value} telah dilakukan dengan bukti transfer.");
    // Anda bisa menambahkan logika untuk memproses pembayaran di sini
  }

  Future<void> sendPaymentProof(String orderId) async {

    if (transferImagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please upload proof of transfer',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }else{
      loadingSendProff.value = true;
      try {
        final token = storage.read('token');
        final formData = dio.FormData.fromMap({
          'image': await dio.MultipartFile.fromFile(transferImagePath.value, filename: transferImagePath.value.split('/').last),
        });

        final response = await _dio.post(
          '$baseURL/api/transaction/$orderId/upload-image',
          data: formData,
          options: dio.Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          print('Payment proof sent successfully');
          Get.toNamed("/home");
        } else {
          print('Failed to send payment proof: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending payment proof: $e');
      }finally{
        loadingSendProff.value = false;
      }
    }

  }


  @override
  void onInit() {
    super.onInit();

  }
}
