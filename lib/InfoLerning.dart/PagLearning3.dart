import 'dart:async';

import 'package:alarm_app/Screen/EditPag.dart';
import 'package:alarm_app/Screen/home_screen.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/main.dart';
import 'package:alarm_app/models/Methods.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LearningPage3 extends StatefulWidget {
  const LearningPage3({Key? key}) : super(key: key);

  @override
  State<LearningPage3> createState() => _LearningPage3State();
}

class _LearningPage3State extends State<LearningPage3> {
  @override
  void initState() {
    setState(() {
      ActivePage = 3;
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
            image: ExactAssetImage('assets/images/SlidThree3.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 125,
              right: 30,
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    ' - نتمنا لك تجربة ممتعة ومفيدة... ',
                    curve: Curves.easeInCirc,
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 1, 19, 17).withOpacity(0.9),
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                onTap: () {},
              ),
            ),
            Positioned(
                bottom: 20,
                left: size.width / 2.5,
                child: Center(
                  child: MaterialButton(
                    color: Color.fromARGB(197, 244, 192, 2).withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        side: BorderSide(
                          color: Color.fromARGB(255, 154, 122, 16)
                              .withOpacity(0.9),
                          width: 1,
                        )),
                    child: Text(
                      "دخول",
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
                        builder: (BuildContext context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: PageView(
                              controller: controllers,
                              children: [HomeScreen(), EditPag()]),
                        ),
                      ));
                      setbool(true);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
