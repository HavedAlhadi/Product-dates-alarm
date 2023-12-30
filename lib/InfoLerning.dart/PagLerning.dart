import 'dart:async';

import 'package:alarm_app/Screen/EditPag.dart';
import 'package:alarm_app/Screen/home_screen.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/main.dart';
import 'package:alarm_app/models/Methods.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  void initState() {
    setState(() {
      ActivePage = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/SlidOne1.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 110,
              right: 50,
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    ' - مرحبا عزيزي...',
                    curve: Curves.easeInCirc,
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 43, 171, 92).withOpacity(0.9),
                      fontSize: 24,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 200),
                  ),
                ],
                onTap: () {},
              ),
            ),
            Positioned(
                bottom: 55,
                left: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_double_arrow_left_rounded,
                    size: 70,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    if (ActivePage == 1) controllerslearning.jumpToPage(1);
                  },
                )),
            Positioned(
                bottom: 35,
                right: 30,
                child: MaterialButton(
                  color: Color.fromARGB(255, 1, 205, 66).withOpacity(0.9),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      side: BorderSide(
                        color:
                            Color.fromARGB(255, 23, 133, 50).withOpacity(0.9),
                        width: 2,
                      )),
                  child: Text(
                    "تخطي",
                    style: TextStyle(
                      color:
                          Color.fromARGB(255, 242, 246, 247).withOpacity(0.9),
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => PageView(
                          controller: controllers,
                          children: [HomeScreen(), EditPag()]),
                    ));
                    setbool(true);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
