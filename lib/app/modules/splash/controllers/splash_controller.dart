import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Future<void> navigateRoute() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offAndToNamed(Routes.AUTH);
  }

  @override
  void onInit() {
    navigateRoute();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
