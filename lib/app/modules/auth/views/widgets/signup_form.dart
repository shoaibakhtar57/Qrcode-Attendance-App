import 'package:attendance_app/app/modules/auth/controllers/auth_controller.dart';
import 'package:attendance_app/app/modules/auth/views/widgets/auth_button.dart';
import 'package:attendance_app/app/modules/auth/views/widgets/auth_formfield.dart';
import 'package:attendance_app/app/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpForm extends GetView<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const sizedBox = SizedBox(height: 8.0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Attendance App',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            sizedBox,
            Container(
              height: 80.0,
              width: 80.0,
              child: Image(
                image: AssetImage('assets/images/ms.png'),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: Get.height * 0.75,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    AuthFormField(
                        controller: controller.name,
                        hint: 'Name',
                        label: 'Name',
                        validator: (value) {
                          if (value!.isEmpty || value.length < 3) {
                            return 'Name is incorrect';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.person)),
                    sizedBox,
                    AuthFormField(
                        controller: controller.email,
                        hint: 'Email',
                        label: 'Email',
                        validator: (value) {
                          if (!value!.isEmail) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.email)),
                    sizedBox,
                    AuthFormField(
                        controller: controller.password,
                        hint: 'Password',
                        label: 'Password',
                        validator: (value) {
                          if (value!.isEmpty || value.length < 3) {
                            return 'Password\'s length must be greater than 3';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.password)),
                    sizedBox,
                    AuthFormField(
                        controller: controller.id,
                        hint: 'ID',
                        label: 'ID',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'ID is incorrect';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.person_outline)),
                    sizedBox,
                    AuthFormField(
                        controller: controller.contact,
                        hint: 'Contact',
                        label: 'Contact',
                        validator: (value) {
                          if (value!.isEmpty ||
                              value.length < 3 ||
                              value.length > 11) {
                            return 'Contact is incorrect';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.phone)),
                    sizedBox,
                    AuthFormField(
                        controller: controller.department,
                        hint: 'Department',
                        label: 'Department',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Department is incorrect';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.location_city)),
                    sizedBox,
                    AuthFormField(
                        controller: controller.subject,
                        hint: 'Subject',
                        label: 'Subject',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Subject is incorrect';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.subject)),
                    sizedBox,
                    AuthFormField(
                        controller: controller.semester,
                        hint: 'Semester',
                        label: 'Semester',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Semester is incorrect';
                          }
                          return null;
                        },
                        prefixIcon: Icon(Icons.subject)),
                    sizedBox,
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthButton(
                    color: Colors.green,
                    title: 'SignUp',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        controller.signupUser(
                            controller.name.text,
                            controller.email.text,
                            controller.password.text,
                            controller.id.text,
                            controller.contact.text,
                            controller.department.text,
                            controller.subject.text,
                            controller.semester.text);
                      }
                    }),
                SizedBox(
                  width: 12.0,
                ),
                AuthButton(
                    color: Colors.green,
                    title: 'Cancel',
                    onTap: () {
                      controller.showSignUp.value = SignUp.none;
                      controller.clearEditors();
                      Get.back();
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
