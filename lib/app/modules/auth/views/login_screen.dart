import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:attendance_app/app/modules/auth/views/widgets/auth_button.dart';
import 'package:attendance_app/app/modules/auth/views/widgets/auth_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class LoginScreen extends GetView<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Obx(
        () => controller.isLoading.value == true
            ? CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Attendance App',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: Get.height * 0.2,
                    width: Get.width * 0.3,
                    child: Image(
                      image: AssetImage('assets/images/ms.png'),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.email,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.email)),
                          validator: (value) {
                            if (!value!.isEmail) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          controller: controller.password,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.password)),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 3) {
                              return 'Password\'s length must be greater than 3';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthButton(
                          color: Colors.green,
                          title: 'Login',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              controller.login(controller.email.text,
                                  controller.password.text);
                            }
                          }),
                      SizedBox(
                        width: 12.0,
                      ),
                      AuthButton(
                          color: Colors.green,
                          title: 'Cancel',
                          onTap: () {
                            controller.clearEditors();
                            Get.back();
                          }),
                    ],
                  )
                ],
              ),
      )),
    );
  }
}
