import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mbakendang/Components/helper.dart';
import 'package:mbakendang/apiRequest/apiServices.dart';


import 'Components/colorsMaster.dart';
import 'Components/menuItem.dart';
import 'MenuDetailPage.dart';
import 'controller/cartController.dart';
import 'controller/pesanController.dart';

class Pesanview extends StatelessWidget {
  final PesanController controller = Get.put(PesanController());
  final CartController  cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
controller.getProfile();
controller.getItems("");
cartController.getCartItems();

    return Scaffold(
      extendBodyBehindAppBar: true,

      body: Container(
        color: Colors.white,
        height: 1.sh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: .23.sh,
                    width: 1.sw,
                    child: Stack(
                      children: [
                        Container(
                            padding: EdgeInsets.all(16),
                            height: 250,
                            width: 1.sh,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                  image: AssetImage('assets/images/login.jpg'),
                                  fit: BoxFit
                                      .cover, // Menyesuaikan ukuran gambar sesuai dengan ukuran container
                                )),
                            child:  Obx(() =>
                                controller.isLoading.value ? SizedBox(height: 50, width: 50, child: Center(child: CircularProgressIndicator())) :  Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama: ${controller.profileData.value['nama']} ', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                                                Text('Nomor HP: ${controller.profileData.value['no_hp']}', style: TextStyle(fontSize: 12.sp, color: Colors.white)),

                                  ],
                                ),
                            ),
                            ),
                        Positioned(
                            top: 20,
                            child: Container(
                              padding: EdgeInsets.all(24),
                              width: 1.sw,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: Image.asset('assets/images/logo.png')),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed("/profile");
                                    },
                                    child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image.asset('assets/images/user.png')),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              // Text('Silahkan pesan menu dibawah.', style: TextStyle(color: Colorsmaster.defaultTextColor, fontWeight: FontWeight.bold), ),
              Container(
                height: .77.sh,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                        Container(
                          height: 50,
                          child: Obx(() {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.categories.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.selectedCategory.value = index;
                                    controller.categories[index] == "Semua" ? controller.getItems("") :
                                    controller.getItems(controller.categories[index]);
                                  },
                                  child: Obx(() {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                      margin: EdgeInsets.only(left: 8),
                                      decoration: BoxDecoration(
                                        color: controller.selectedCategory.value == index ? Colorsmaster.backgroundColor : Colors.white,
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Text(
                                          controller.categories[index],
                                          style: TextStyle(color: controller.selectedCategory.value == index ? Colors.white : Colorsmaster.backgroundColor),
                                        ),
                                      ),
                                    );
                                  }),
                                );
                              },
                            );
                          }),
                        ),
                        // Items Section
                        Expanded(
                          child: Obx(() {
                            var items = controller.items;
                            return controller.isLoadingBarang.value ? Center(child: CircularProgressIndicator()) :  ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return  MenuItem(
                                  id: items[index]['id'],
                                  imageUrl: baseURL+items[index]['image'],
                                  name: items[index]['nama'],
                                  price: formatRupiah(items[index]['harga']),
                                  onAddToCart: (){
                                    Get.to(MenuItemDetailPage(menuItem: item));
                                  }
                                );
                              },
                            );
                          }),
                        ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),


      floatingActionButton: Obx(() {
      return FloatingActionButton(
        onPressed: () {
          Get.toNamed('/cart');
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(width: double.infinity, height: double.infinity,),
            Icon(Icons.shopping_cart),
            if (cartController.totalQuantity.value > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '${cartController.totalQuantity.value}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
          ],
        ),
      );
    }),
    );
  }
}
