import 'package:alarm_app/Screen/home_screen.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/db_helper/ProductSer.dart';
import 'package:alarm_app/models/ProductModel.dart';
import 'package:alarm_app/notification/notification.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

String getDateNow(DateTime d) {
  var now = d;
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  return formattedDate;
}

setbool(bool d) async {
  try {
    SharedPreferences shar = await SharedPreferences.getInstance();
    shar.setBool("IsInstall", d);
    IsInstall = shar.getBool("IsInstall")!;
    print(IsInstall.toString());
  } catch (es) {}
}

setboolNoti(bool d) async {
  try {
    SharedPreferences shar = await SharedPreferences.getInstance();
    shar.setBool("IsNoti", d);
    IsNotNoti = shar.getBool("IsNoti")!;
    print(IsNotNoti.toString());
  } catch (es) {}
}

getBoolNoti() async {
  SharedPreferences sharad = await SharedPreferences.getInstance();
  try {
    IsNotNoti = sharad.getBool("IsNoti")!;
  } catch (ex) {}
}

getBool() async {
  SharedPreferences sharad = await SharedPreferences.getInstance();
  try {
    IsInstall = sharad.getBool("IsInstall")!;
  } catch (ex) {}
}

//Function Notification end Expier message
void NotificationEnd() async {
  for (int i = 0; i < bad.length; i++) {
    await NotificationService.showNotification(
        title: "* للأسف !",
        body: bad[i].name! +
            " أصبح منتهي الصلاحية آمل أنه لم يتبقى منه الكثير... ",
        payload: {
          "navigate": "true",
        },
        actionButtons: [
          NotificationActionButton(
            key: 'check',
            label: 'فتح في التطبيق',
            color: Color.fromARGB(255, 249, 4, 4),
          )
        ]);
  }
}

//Function Notification Soon end Expier message
void NotificationSoonend() async {
  for (int i = 0; i < good.length; i++) {
    await NotificationService.showNotification(
        title: "* تنبيه !",
        body: good[i].name! + " تنتهي صلاحيته بتاريخ: " + good[i].Expier!,
        payload: {
          "navigate": "true",
        },
        actionButtons: [
          NotificationActionButton(
            key: 'check',
            label: 'فتح في التطبيق',
            color: Color.fromARGB(255, 76, 175, 172),
          )
        ]);
  }
}

launchURLApp(String link) async {
  var url = Uri.parse(link);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    try {
      throw 'Could not launch $url';
    } catch (D) {}
  }
}

final _ProdService = ProductService();
getAllProdDetails() async {
  var Prods = await _ProdService.readAllProducts();
  recentProducts = [];
  Prods.forEach((prod) {
    var ProdModel = Product();
    ProdModel.id = prod['id'];
    ProdModel.name = prod['name'];
    ProdModel.Expier = prod['Expier'];
    recentProducts.add(ProdModel);
  });
}

//Function culculate Count Prodect Healtly, end, good
void runFilterReport() {
  Healthy = [];
  good = [];
  bad = [];
  for (int i = 0; i < recentProducts.length; i++) {
    Product Product1 = recentProducts[i];
    int daysLeft =
        DateTime.now().difference(DateTime.parse(Product1.Expier!)).inDays;
    daysLeft = daysLeft < 0 ? -daysLeft : 0;
    if (daysLeft < 40 && daysLeft > 1)
      good.add(Product1);
    else if (daysLeft == 0)
      bad.add(Product1);
    else
      Healthy.add(Product1);
  }
}
