import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutterfarm_bottomnavbar/Animated_BottomNav/constants/color.dart';
import 'package:flutterfarm_bottomnavbar/Animated_BottomNav/constants/text_style.dart';
import 'package:flutterfarm_bottomnavbar/Animated_BottomNav/data/model.dart';
import 'package:flutterfarm_bottomnavbar/Animated_BottomNav/widgets/custom_paint.dart';

class HomePageContainer extends StatefulWidget {
  const HomePageContainer({Key? key}) : super(key: key);

  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
  int selectBtn = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: navigationBar(),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 0.0),
          topRight: Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 0.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() => selectBtn = i),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.1 : 0.0;
    return SizedBox(
      width: 75.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              navBtn[i].imagePath,
              color: isActive ? selectColor : black,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              navBtn[i].name,
              style: isActive ? bntText.copyWith(color: selectColor) : bntText,
            ),
          )
        ],
      ),
    );
  }
}
