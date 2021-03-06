import 'package:flutter/material.dart';
import 'package:flutter_healthcare/app/modules/schedule_doctor/views/components/button.dart';

class TimeLineCard extends StatelessWidget {
  TimeLineCard({
    Key? key,
    required this.timeStart,
    required this.timeFinish,
    required this.onPressed,
  }) : super(key: key);

  final String timeStart, timeFinish;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xFF188A6F),
        borderRadius: BorderRadius.all(
          Radius.circular(19),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            color: Color(0xFF000000).withOpacity(0.25),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "${timeStart} - ${timeFinish}",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          ButtonCustom(
            text: 'Xoá',
            color: Color(0xFFD92828),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
