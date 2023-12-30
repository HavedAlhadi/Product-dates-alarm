import 'dart:ui';
import 'package:alarm_app/Widget/Add_Product.dart';
import 'package:flutter/material.dart';

class AnimtLoded extends StatefulWidget {
  const AnimtLoded({Key? key, required this.indexPro, required this.list})
      : super(key: key);
  final int indexPro;
  final list;
  @override
  State<AnimtLoded> createState() => Animt_LodedState();
}

class Animt_LodedState extends State<AnimtLoded> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 300,
        width: 300,
        child: Center(
          child: AnimtLodedBox(
              theChild: NewProduct(
                index: widget.indexPro,
                list: widget.list,
              ),
              theHeight: 300.0,
              theWidth: 300.0),
        ),
      ),
    );
  }
}

class AnimtLodedBox extends StatelessWidget {
  const AnimtLodedBox(
      {Key? key,
      required this.theWidth,
      required this.theHeight,
      required this.theChild})
      : super(key: key);
  final double theWidth;
  final double theHeight;
  final theChild;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: theWidth,
        height: theHeight,
        color: Colors.transparent,
        child: Stack(
          children: [
            //blur effect ==> the third layer of stack
            BackdropFilter(
              filter: ImageFilter.blur(
                //sigmaX is the Horizontal blur
                sigmaX: 4.0,
                //sigmaY is the Vertical blur
                sigmaY: 4.0,
              ),
              //we use this container to scale up the blur effect to fit its
              //  parent, without this container the blur effect doesn't appear.
              child: Container(),
            ),
            //gradient effect ==> the second layer of stack
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.13)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      //begin color
                      Colors.white.withOpacity(0.15),
                      //end color
                      Colors.white.withOpacity(0.05),
                    ]),
              ),
            ),
            //child ==> the first/top layer of stack
            Center(child: theChild),
          ],
        ),
      ),
    );
  }
}
