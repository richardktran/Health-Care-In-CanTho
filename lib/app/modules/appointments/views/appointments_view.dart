import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/appointments/controllers/appointment.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/components/appointnent_card.dart';
import 'package:flutter_healthcare/app/modules/appointments/views/constants.dart';
import 'package:flutter_healthcare/app/routes/app_pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/appointments_controller.dart';

class AppointmentsView extends GetView<AppointmentsController> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text('Appointments', style: TextStyle(color: fgColor)),
              centerTitle: true,
              actions: <Widget>[
                new IconButton(
                    onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
                    icon: new Icon(
                      Icons.filter_list_alt,
                      color: fgColor,
                    ))
              ],
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: fgColor,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.HOME);
                  })),
          endDrawer: buildDrawer(context),
          body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Obx(() {
              return buildList(context);
            }),
          )),
    );
  }

  Widget buildList(BuildContext context) {
    var streamBuilder = StreamBuilder<List<Appointment>>(
        stream:
            controller.getData(controller.less.value, controller.greater.value),
        builder: (BuildContext context,
            AsyncSnapshot<List<Appointment>> appointmentsSnapshot) {
          if (appointmentsSnapshot.hasError)
            return new Text('Error: ${appointmentsSnapshot.error}');
          switch (appointmentsSnapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (appointmentsSnapshot.data!.isEmpty) {
                return buildNullList(context);
              }
              return new ListView(
                  children: appointmentsSnapshot.data!.map((Appointment app) {
                return Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Slidable(
                        child: AppointmentCard(
                          image: 'assets/images/tooth.png',
                          name: app.specialist,
                          appointment: app,
                        ),
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.2,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Cancel',
                            icon: Icons.cancel,
                            onTap: () {},
                          )
                        ]));
              }).toList());
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
            controller.less.value = "Z";
            controller.greater.value = "A";
          } else {
            controller.less.value = text;
            controller.greater.value = text;
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
