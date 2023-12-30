import 'package:alarm_app/Screen/home_screen.dart';
import 'package:alarm_app/constants.dart';
import 'package:flutter/material.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(5),
      // color: kHourColor,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 3, 246, 124),
                                    blurRadius: 10.0,
                                  ),
                                ]),
                            child: Icon(
                              Icons.circle_rounded,
                              color: Color.fromARGB(255, 21, 135, 63),
                              size: 17,
                            )),
                      ),
                      Text(
                        Healthy.length.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 2, 199, 74),
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "سليمة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    ]),
              ),
              ///////////////////////////////////////s
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 255, 157, 0),
                                    blurRadius: 10.0,
                                  ),
                                ]),
                            child: Icon(
                              Icons.circle_rounded,
                              color: Color.fromARGB(255, 192, 109, 8),
                              size: 17,
                            )),
                      ),
                      Text(
                        good.length.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 157, 0),
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "مقربة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    ]),
              ),
              ///////////////////////////////////////s
              Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 231, 6, 13),
                                    blurRadius: 10.0,
                                  ),
                                ]),
                            child: Icon(
                              Icons.circle_rounded,
                              color: Color.fromARGB(255, 169, 4, 4),
                              size: 17,
                            )),
                      ),
                      Text(
                        bad.length.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 231, 6, 13),
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "تالفة",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Padding TitelPart(String text, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          color: blue.withOpacity(0.7),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Icon(
                icon,
                color: White,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 5),
                child: Text(
                  text + "    ",
                  style: TextStyle(
                    color: White.withOpacity(0.9),
                    fontWeight: FontWeight.w800,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Icon(
          text == "الإحصائيات"
              ? null
              : text == "قائمة المنتجات"
                  ? null
                  : Icons.access_alarm_sharp,
          color: blue,
          size: 30,
        )
      ],
    ),
  );
}
