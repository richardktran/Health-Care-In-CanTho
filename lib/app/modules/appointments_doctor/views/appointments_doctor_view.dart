import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/common/widgets/background.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_appbar.dart';
import 'package:flutter_healthcare/app/data/helper/create_chatroom_helpers.dart';
import 'package:flutter_healthcare/app/common/widgets/custom_loader.dart';
import 'package:flutter_healthcare/app/data/helper/datetime_helpers.dart';
import 'package:flutter_healthcare/app/data/helper/dialog.dart';
import 'package:flutter_healthcare/app/data/models/appointment.dart';
import 'package:flutter_healthcare/app/modules/home_doctor/views/components/appointment_cart.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/appointments_doctor_controller.dart';

class AppointmentsDoctorView extends GetView<AppointmentsDoctorController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
          title: 'Danh sách cuộc hẹn',
        ),
        body: Stack(
          children: [
            Background(height: MediaQuery.of(context).size.height),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Obx(
                () {
                  return buildDoctorList(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoctorList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var streamBuilder = StreamBuilder<List<AppointmentModel>>(
        stream: controller.getDoctorData(
            controller.less.value, controller.greater.value),
        builder: (BuildContext context,
            AsyncSnapshot<List<AppointmentModel>> appointmentsSnapshot) {
          if (appointmentsSnapshot.hasError)
            return new Text('Error: ${appointmentsSnapshot.error}');
          switch (appointmentsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return LoadingScreen(height: size.height);
            default:
              if (appointmentsSnapshot.data!.isEmpty) {
                return buildNullList(context);
              }
              return Padding(
                padding: const EdgeInsets.only(left: 16),
                child: new ListView(
                    children:
                        appointmentsSnapshot.data!.map((AppointmentModel app) {
                  return Container(
                    child: Slidable(
                      child: AppointmentCard(
                        height: MediaQuery.of(context).size.height * 0.18,
                        doctor_image: 'assets/images/avt_doctor.png',
                        doctor_name: app.name,
                        // email: app.patient,
                        date: DateTimeHelpers.timestampsToDate(
                            app.appointment_date!),
                        time: DateTimeHelpers.timestampsToTime(
                            app.appointment_date!),
                        status: app.status!,
                        onMessage: () {
                          CreateChatRoom().createChatroomAndStartConversation(
                              app.patient.toString(), app.name.toString());
                        },
                        onCancel: () {
                          DialogHelper.showDialog(
                            content: 'Xác nhận huỷ lịch hẹn?',
                            confirmText: 'Xác nhận',
                            onConfirm: () {
                              //controller.cancelAppointment(index);
                            },
                          );
                        },
                      ),
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.2,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Cancel',
                          icon: Icons.cancel,
                          onTap: () {},
                        )
                      ],
                    ),
                  );
                }).toList()),
              );
          }
        });
    return streamBuilder;
  }

  Widget buildDrawer(BuildContext context) {
    return Column(children: [
      Container(
          // margin: const EdgeInsets.only(top: 24),
          width: 200,
          height: 300,
          child: Drawer(
            child: Material(
              child: ListView(
                children: <Widget>[
                  buildMenuItem(
                      text: 'All',
                      icon: Icons.all_out_outlined,
                      iconColor: Colors.red[300]),
                  buildMenuItem(
                      text: 'Active',
                      icon: Icons.fiber_manual_record,
                      iconColor: Colors.green[300]),
                  buildMenuItem(
                      text: 'Waiting',
                      icon: Icons.fiber_manual_record,
                      iconColor: Colors.amber[300]),
                  buildMenuItem(
                      text: 'Done',
                      icon: Icons.fiber_manual_record,
                      iconColor: Colors.blue[300])
                ],
              ),
            ),
          ))
    ]);
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    required iconColor,
  }) {
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(text),
      hoverColor: hoverColor,
      onTap: () {
        if (controller.statusFilter != text) {
          if (text == "All") {
            controller.less.value = "z";
            controller.greater.value = "a";
          } else {
            controller.less.value = text.toLowerCase();
            controller.greater.value = text.toLowerCase();
          }
          controller.statusFilter = text;
        }
        Get.back();
      },
    );
  }

  Widget buildNullList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Image(
              image: AssetImage('assets/images/avt_doctor.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text('Sorry, no appointment yet!',
                style: TextStyle(fontSize: 20, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
