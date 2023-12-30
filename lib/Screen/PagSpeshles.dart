import 'dart:async';
import 'package:alarm_app/InfoLerning.dart/PagLearning3.dart';
import 'package:alarm_app/InfoLerning.dart/PagLearning2.dart';
import 'package:alarm_app/InfoLerning.dart/PagLerning.dart';
import 'package:alarm_app/Screen/EditPag.dart';
import 'package:alarm_app/Screen/home_screen.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/main.dart';
import 'package:alarm_app/models/Methods.dart';
import 'package:alarm_app/notification/notification.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

//دالة عرض التنبية في الخلفية
void NotificationSoonend1() async {
  await NotificationService.showNotification(
      title: "* عزيزي !",
      body: " لا تنسى مراجعة المنتجات بشكل مستمر... ",
      payload: {
        "navigate": "true",
      },
      actionButtons: [
        NotificationActionButton(
          key: 'check',
          label: 'التحقق من التواريخ',
          color: Color.fromARGB(255, 76, 175, 172),
        )
      ]);
}

void callbackDispatcher() async {
  // initial notifications
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initializeNotification();
  Workmanager().executeTask((task, inputData) {
    NotificationSoonend1();
    return Future.value(true);
  });
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double width = 0;
  double widthText = 0;
  double height = 0;
  Color color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  void initState() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    setState(() {
      getBool();
      getBoolNoti();
    });
    Timer(Duration(seconds: 1), () {
      if (width <= 200 && height <= 200) {
        setState(() {
          width += 90;
          height += 90;
        });
      }
    });
    Future.delayed(Duration(seconds: 3), () {
      if (IsInstall)
        try {
          runFilterReport();
          if (!IsNotNoti) {
            NotificationEnd();
            NotificationSoonend();
          }
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Directionality(
              textDirection: TextDirection.rtl,
              child: PageView(
                  controller: controllers, children: [HomeScreen(), EditPag()]),
            ),
          ));
        } catch (es) {}
      else
        try {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Directionality(
              textDirection: TextDirection.rtl,
              child: PageView(
                  controller: controllerslearning,
                  children: [LearningPage(), LearningPage2(), LearningPage3()]),
            ),
          ));
        } catch (sd) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: (size.height / 8)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    width: width,
                    height: height,
                    duration: const Duration(seconds: 2),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/IconApp.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: _borderRadius),
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText(
                      //'تنبيهات التاريخ',
                      'Date Alerts',
                      curve: Curves.easeInCirc,
                      textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                  ],
                  onTap: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                child: TextButton(
                  onPressed: () {
                    launchURLApp("https://t.me/Haved7");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.telegram,
                      ),
                      Text(
                        ' فريق التطوير',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
