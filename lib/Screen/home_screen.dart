import 'dart:math';
import 'package:alarm_app/Screen/PagSpeshles.dart';
import 'package:alarm_app/Widget/Card.dart';
import 'package:alarm_app/Widget/MyHeader.dart';
import 'package:alarm_app/Widget/Reports.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/models/Methods.dart';
import 'package:alarm_app/models/ProductModel.dart';
import 'package:alarm_app/profile_pag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workmanager/workmanager.dart';

List<Product> ListEndProd = [];
List<Product> Healthy = [];
List<Product> good = [];
List<Product> bad = [];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool online = true;
  GlobalKey<ScaffoldState> scaffolKey = GlobalKey<ScaffoldState>();
//Function culculate Count Prodect EndProd
  void runFilterEndProd() {
    List<Product> results = [];
    for (int i = 0; i < recentProducts.length; i++) {
      Product Product1 = recentProducts[i];
      int daysLeft =
          DateTime.now().difference(DateTime.parse(Product1.Expier!)).inDays;
      daysLeft = daysLeft < 0 ? -daysLeft : 0;
      if (daysLeft < 40) {
        results.add(Product1);
        //print(daysLeft.toString());
      }
    }
    setState(() {
      ListEndProd = results;
      ListEndProd.sort((a, b) {
        var adate = DateTime.parse(a.Expier.toString());
        var bdate = DateTime.parse(b.Expier.toString());
        return adate.compareTo(bdate);
      });
    });
  }

//Function culculate Count Prodect Healtly, end, good
  void runFilterReports() {
    Healthy = [];
    good = [];
    bad = [];
    for (int i = 0; i < recentProducts.length; i++) {
      Product Product1 = recentProducts[i];
      int daysLeft =
          DateTime.now().difference(DateTime.parse(Product1.Expier!)).inDays;
      daysLeft = daysLeft < 0 ? -daysLeft : 0;
      setState(() {
        if (daysLeft < 40 && daysLeft > 1)
          good.add(Product1);
        else if (daysLeft == 0)
          bad.add(Product1);
        else
          Healthy.add(Product1);
      });
    }
  }

  @override
  void initState() {
    getAllProdDetails();
    runFilterEndProd();
    runFilterReports();
    Workmanager().registerPeriodicTask(
      "1",
      "periodic Notification",
      frequency: Duration(hours: 12),
    );

    Workmanager().registerPeriodicTask(
      "2",
      "periodic Notification at day",
      frequency: Duration(days: 1),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: scaffolKey,
        drawer: DrawerPage(i: 0),
        appBar: PreferredSize(
          preferredSize: Size(
            double.infinity,
            size.height >= 550 ? size.height / 1.65 : size.height / 1.45,
          ),
          //Container Photo Home Pag..
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: <Widget>[
                    MyHeader(
                      image: "assets/images/Ads1.jpg",
                      textTop: "معا نحو الأفضل ",
                      textBottom: "لتحقيق أرباح مذهلة",
                      offset: 10.0,
                    ),
                    Positioned(
                        top: 30,
                        right: 7,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              "assets/icons/menushort.svg",
                              width: 25.0,
                              color: White,
                            ),
                            //color: White,
                            onPressed: () {
                              scaffolKey.currentState!.openDrawer();
                            },
                          ),
                        )),
                    Positioned(
                        bottom: -5,
                        child: Container(
                            height: 40,
                            child: TitelPart(
                                "الإحصائيات", Icons.ac_unit_rounded))),
                    Positioned(
                        bottom: 0,
                        left: 16,
                        child: Icon(
                          Icons.add_chart_sharp,
                          color: blue,
                          size: 30,
                        )),
                  ],
                ),
              ),
              Reports(),
              TitelPart("التنبيهات ", Icons.ac_unit_rounded),
            ],
          ),
        ),
        body: ListEndProd.isNotEmpty
            ? SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              padding:
                                  const EdgeInsets.only(right: 20.0, top: 0),
                              scrollDirection: Axis.vertical,
                              itemCount: ListEndProd.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RecentsProducts(
                                  index: index,
                                  list: ListEndProd,
                                );
                              }),
                        ),
                      ],
                    )),
              )
            : SizedBox(
                child: Padding(
                padding:
                    EdgeInsets.all(size.height >= 550 ? size.height / 20 : 10),
                child: Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/icons/like.svg",
                        width: size.height >= 550 ? 100.0 : 70,
                        color: blue.withOpacity(0.9),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("لا توجد تنبيهات حالياً"),
                    ),
                  ],
                )),
              )),
      ),
    );
  }
}
