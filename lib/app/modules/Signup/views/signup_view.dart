import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/modules/Signup/views/signup_form.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Background(height: size.height),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        'assets/images/avt_doctor.png',
                      ),
                      minRadius: 60,
                      maxRadius: 60,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text(
                      'Đăng ký',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    SignUpForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
