import 'package:attendance_app/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final currentUser = Get.arguments;

  RxBool isLoading = false.obs;

  Future<void> signOut() async {
    isLoading.value = true;
    await FirebaseAuth.instance.signOut();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
