//دالة اشعار التوضيح
import 'package:alarm_app/constants.dart';
import 'package:flutter/material.dart';

void ShowMySnakbar(BuildContext context, String ContantText, Color Bg) {
  var snakbar = SnackBar(
    content: Text(
      ContantText,
      style: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    duration: Duration(milliseconds: 1000),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
        side: BorderSide(color: White)),
    backgroundColor: Bg,
    dismissDirection: DismissDirection.horizontal,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(top: 50, bottom: 0, left: 50, right: 50),
    clipBehavior: Clip.antiAlias,
  );
  ScaffoldMessenger.of(context).showSnackBar(snakbar);
}

//رسالة التاكد من الحذف
Future<void> ShowAlertdialog(context, Function function, String Name) async {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white54),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
            ),
            backgroundColor: Color.fromARGB(157, 19, 69, 74),
            title: Text(
              "تنبيه!",
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 220, 3, 90)),
            ),
            content: Text(
              "هل تريد بالتاكيذ حذف ${Name}؟ ",
              style: TextStyle(fontSize: 15, color: White),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    function();
                    Navigator.pop(context);
                  },
                  child: Text("نعم",
                      style: TextStyle(fontSize: 19, color: White))),
              SizedBox(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:
                      Text("لا", style: TextStyle(fontSize: 20, color: White)))
            ],
          ),
        );
      });
}
