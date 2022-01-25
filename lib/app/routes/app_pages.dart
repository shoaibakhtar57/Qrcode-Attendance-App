import 'package:get/get.dart';

import 'package:attendance_app/app/modules/auth/bindings/auth_binding.dart';
import 'package:attendance_app/app/modules/auth/views/auth_view.dart';
import 'package:attendance_app/app/modules/home/bindings/home_binding.dart';
import 'package:attendance_app/app/modules/home/views/home_view.dart';
import 'package:attendance_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:attendance_app/app/modules/profile/views/profile_view.dart';
import 'package:attendance_app/app/modules/splash/bindings/splash_binding.dart';
import 'package:attendance_app/app/modules/splash/views/splash_view.dart';
import 'package:attendance_app/app/modules/student/bindings/student_binding.dart';
import 'package:attendance_app/app/modules/student/views/student_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT,
      page: () => StudentView(),
      binding: StudentBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}
