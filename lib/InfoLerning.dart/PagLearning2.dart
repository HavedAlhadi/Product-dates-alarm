import 'dart:async';

import 'package:alarm_app/Screen/EditPag.dart';
import 'package:alarm_app/Screen/home_screen.dart';
import 'package:alarm_app/constants.dart';
import 'package:alarm_app/main.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LearningPage2 extends StatefulWidget {
  const LearningPage2({Key? key}) : super(key: key);

  @override
  State<LearningPage2> createState() => _LearningPage2State();
}

class _LearningPage2State extends State<LearningPage2> {
  @override
  void initState() {
    setState(() {
      ActivePage = 2;
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
            image: ExactAssetImage('assets/images/SlidTow2.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 120,
              right: 55,
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    '- نسعى إلى خدمتك... ',
                    curve: Curves.easeInCirc,
                    textStyle: TextStyle(
                      color: Color.fromARGB(255, 167, 91, 3).withOpacity(0.9),
                      fontSize: 24,
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
                bottom: 50,
                left: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_double_arrow_left_rounded,
                    size: 70,
                    color: Color.fromARGB(255, 167, 91, 3),
                  ),
                  onPressed: () {
                    if (ActivePage == 2) controllerslearning.jumpToPage(2);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
