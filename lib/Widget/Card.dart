import 'package:alarm_app/Widget/Alarte_Add_Ui.dart';
import 'package:alarm_app/Widget/DrawCirclePersent.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentsProducts extends StatefulWidget {
  final int index;
  final list;
  const RecentsProducts({Key? key, required this.index, required this.list})
      : super(key: key);

  @override
  State<RecentsProducts> createState() => _RecentsProductsState();
}

class _RecentsProductsState extends State<RecentsProducts> {
  final DateFormat dateFormat = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    Product Product1 = widget.list[widget.index];
    int daysLeft =
        DateTime.now().difference(DateTime.parse(Product1.Expier!)).inDays;
    daysLeft = daysLeft < 0 ? -daysLeft : 0;
    double percent = daysLeft / 100;
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Row(
        children: <Widget>[
          //الأطار الجانبي
          Container(
            margin: EdgeInsets.only(
              bottom: 15.0,
            ),
            height: 95.0,
            width: 15.0,
            decoration: BoxDecoration(
              color: _getColor(context, percent),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
          ),
          //الإطار المحتوي
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 5.0),
            height: 95.0,
            width: size.width - 50,
            decoration: BoxDecoration(
              color: kCardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      Product1.name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range_outlined,
                          color: _getColor(context, percent),
                          size: 17.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          "${DateTime.now().weekday == DateTime.parse(Product1.Expier!).weekday && DateTime.now().day == DateTime.parse(Product1.Expier!).day ? "Today" : DateFormat.yMMMEd().format(DateTime.parse(Product1.Expier!))}, ${dateFormat.format(DateTime.parse(Product1.Expier!))}",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: size.width / 26,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.receipt,
                          color: _getColor(context, percent),
                          size: 17.0,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          percent >= 0.4
                              ? "تاريخ جديد"
                              : percent >= 0.01 && percent < 0.4
                                  ? "منتج مقرب"
                                  : "منتهي الصلاحية",
                          style: TextStyle(
                            color: kTextColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  left: 5.0,
                  top: 7,
                  child: CustomPaint(
                    size: Size.zero,
                    foregroundPainter: CountdownPainter(
                      bgColor: kBGColor,
                      lineColor: _getColor(context, percent),
                      percent: percent,
                      width: 4.0,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "$daysLeft",
                            style: TextStyle(
                              color: _getColor(context, percent),
                              fontSize: 26.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "يوم متبقي",
                            style: TextStyle(
                              color: _getColor(context, percent),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AnimtLoded(
                indexPro: widget.index,
                list: widget.list,
              );
            });
      },
    );
  }

  _getColor(BuildContext context, double percent) {
    if (percent >= 0.4) {
      return Theme.of(context).colorScheme.secondary;
    } else if (percent < 0.1) return red;

    return kHourColor;
  }
}
