import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Paymentcontroller extends GetxController {
  var amount = 0.0.obs;
  var items = <Map<String, dynamic>>[].obs;
  var transferImagePath = ''.obs;

  final ImagePicker _picker = ImagePicker();

  // Contoh barang yang sudah dipesan
  void fetchItems() {
    items.value = [
      {'name': 'Kopi Hitam', 'price': 15000, 'quantity': 2},
      {'name': 'Roti Bakar', 'price': 10000, 'quantity': 1},
      // Tambahkan item lainnya di sini
    ];
    calculateTotalAmount();
  }

  void calculateTotalAmount() {

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
  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }
}
