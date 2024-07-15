
import 'package:get/get.dart';
import 'package:mbakendang/paymentView.dart';
import 'package:mbakendang/regisrterView.dart';

import 'cartView.dart';
import 'controller/binding/loginBinding.dart';
import 'homeView.dart';
import 'pesanView.dart';
import 'login.dart';
import 'splashScreen.dart';

class RoutePage {
  List<GetPage> route = [
    GetPage(name: "/", page: () => SplashScreen()),
    GetPage(name: "/login", page: () => LoginView(), binding: LoginBinding()),
    GetPage(name: "/pesan", page: () => Pesanview()),
    GetPage(name: "/home", page: () => HomeView()),
    GetPage(name: "/register", page: () => RegisterView()),
    GetPage(name: "/cart", page: () => CartView()),
    GetPage(name: "/payment", page: () => PaymentView()),
  ];
}
