import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/constant.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custombutton.dart';
import 'package:flutter_healthcare/app/data/models/address.dart';
import 'package:flutter_healthcare/app/modules/doctorinformation/controllers/doctorinformation_controller.dart';
import 'package:flutter_healthcare/app/modules/home_doctor/controllers/home_doctor_controller.dart';
import 'package:get/get.dart';

import 'constants.dart';

class UpdateView extends StatelessWidget {
  UpdateView({Key? key}) : super(key: key);

  final DoctorinformationController controller = Get.find();
  final HomeDoctorController homeDoctorController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final textFeildBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: primaryColor));

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        floatingActionButton: Container(
          height: 60,
          width: 60,
          child: FloatingActionButton.extended(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              _formKey.currentState!.save();
              FocusScope.of(context).unfocus();
              controller.updateDoctorInfo();
              controller.reLoadData();
              homeDoctorController.loadData();
              Get.back();
            },
            label: Icon(Icons.done),
            backgroundColor: primaryColor,
          ),
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Background(height: MediaQuery.of(context).size.height),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 26),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      color: primaryColor,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Container(
                          height: 650,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: Text(
                                  'Nh???p v??o th??ng tin',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 26,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'T??n: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initName,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  border: textFeildBorder,
                                  enabledBorder: textFeildBorder,
                                  focusedBorder: textFeildBorder,
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          BorderSide(color: secondaryColor)),
                                  disabledBorder: textFeildBorder,
                                  hintText: controller.newDoctor.name,
                                  hintStyle: textStyle,
                                ),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.name = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.name ==
                                          'VD: V?? T??? Thi??n')
                                    return 'H??y nh???p v??o t??n!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'S??? ??i???n tho???i: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initPhone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 20),
                                  border: textFeildBorder,
                                  enabledBorder: textFeildBorder,
                                  focusedBorder: textFeildBorder,
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide:
                                          BorderSide(color: secondaryColor)),
                                  disabledBorder: textFeildBorder,
                                  hintText: controller.newDoctor.phone,
                                  hintStyle: textStyle,
                                ),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.phone = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.phone ==
                                          'VD: 0812305346')
                                    return 'H??y nh???p v??o s??? ??i???n tho???i!';
                                  if (value != '' &&
                                      !GetUtils.isPhoneNumber(value!))
                                    return 'S??? ??i???n tho???i kh??ng h???p l???!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.architecture,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Chuy??n khoa: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initSpecialist,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    border: textFeildBorder,
                                    enabledBorder: textFeildBorder,
                                    focusedBorder: textFeildBorder,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor)),
                                    disabledBorder: textFeildBorder,
                                    hintText: controller.newDoctor.specialist,
                                    hintStyle: textStyle),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.specialist = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.specialist ==
                                          'VD: Tim m???ch')
                                    return 'H??y nh???p v??o chuy??n khoa!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.app_registration_rounded,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Gi???i thi???u: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initAbout,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    border: textFeildBorder,
                                    enabledBorder: textFeildBorder,
                                    focusedBorder: textFeildBorder,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor)),
                                    disabledBorder: textFeildBorder,
                                    hintText: controller.newDoctor.about,
                                    hintStyle: textStyle),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.about = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.about ==
                                          'VD: B??c s?? n???i ti???ng t???ng tham gia c???y gh??p tim ??? n?????c ngo??i')
                                    return 'H??y nh???p v??o gi???i thi???u!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.home_work,
                                    color: primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      '?????a ch??? trung t??m: ',
                                      style: textStyle,
                                    ),
                                  )
                                ],
                              ),
                              TextFormField(
                                style: informationText,
                                initialValue: controller.initCenterAddreess,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    border: textFeildBorder,
                                    enabledBorder: textFeildBorder,
                                    focusedBorder: textFeildBorder,
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide:
                                            BorderSide(color: secondaryColor)),
                                    disabledBorder: textFeildBorder,
                                    hintText:
                                        controller.newDoctor.centeraddress,
                                    hintStyle: textStyle),
                                onSaved: (value) {
                                  if (value != '')
                                    controller.newDoctor.centeraddress = value;
                                },
                                validator: (value) {
                                  if (value == '' &&
                                      controller.newDoctor.centeraddress ==
                                          'VD: 331 ???????ng Ba Th??ng Hai, H??ng l???i')
                                    return 'H??y nh???p v??o ?????a ch??? trung t??m!';
                                },
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_rounded,
                                      color: primaryColor),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Text(
                                      '?????a ch???: ',
                                      style: textStyle,
                                    ),
                                  ),
                                  DropdownButton<AddressModel>(
                                    items: controller.listAddress
                                        .map((AddressModel value) {
                                      return DropdownMenuItem<AddressModel>(
                                        value: value,
                                        child: Text(
                                          value.name!,
                                          style: informationText,
                                        ),
                                      );
                                    }).toList(),
                                    menuMaxHeight: 150,
                                    onChanged: (value) {
                                      controller.hint = value!.name;
                                      controller.newDoctor.addressRef =
                                          value.reference;
                                    },
                                    hint: DropdownMenuItem<String>(
                                      value: controller.hint,
                                      child: Text(
                                        controller.hint,
                                        style: informationText,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )));
  }
}
