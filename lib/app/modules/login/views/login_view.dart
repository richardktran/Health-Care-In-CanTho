import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_textformfield.dart';
import 'package:flutter_healthcare/app/modules/Signup/views/signup_view.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Background(
              height: MediaQuery.of(context).size.height,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 24, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipOval(
                      child: Container(
                        height: 115,
                        width: 115,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Image.asset('assets/images/avt_doctor.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  _buildLoginForm(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Color primaryColor() {
  //   return Color.fromARGB(255, 252, 217, 133);
  // }

  Form _buildLoginForm(BuildContext context) {
    return Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(46, 30, 46, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: buildDecorationTextFormField(
                        hintText: 'Email...', icon: Icons.person),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email không được rỗng";
                      } else if (!GetUtils.isEmail(value)) {
                        return "Vui lòng nhập email hợp lệ";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.email = value!;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    decoration: buildDecorationTextFormField(
                        hintText: 'Mật khẩu...', icon: Icons.lock),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mật khẩu không được rỗng';
                      } else if (value.length < 6) {
                        return 'Vui lòng nhập chính xác mật khẩu';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      controller.password = value!;
                    },
                  ),
                  SizedBox(height: 46),
                  InkWell(
                    onTap: () => controller.handleSignIn(context),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: primaryColor,
                      ),
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => Get.toNamed(Routes.FORGOTPASSWORD),
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.FORGOTPASSWORD);
                },
                child: Text('Quên mật khẩu?',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 16, 26, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '___________',
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                    child: Text(
                      'hoặc đăng nhập với',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  Text(
                    '___________',
                    style: TextStyle(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, right: 80, top: 24),
              child: InkWell(
                onTap: () => controller.signInWithGoogle(),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 12.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/google_icon.png',
                          height: 24,
                          width: 24,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          'GOOGLE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bạn chưa có tài khoản? ",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(SignupView());
                  },
                  child: Text(
                    'Đăng ký',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
