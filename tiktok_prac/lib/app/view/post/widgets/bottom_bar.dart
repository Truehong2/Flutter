import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tiktok_practice/app/data/service/video_controll.dart';
import 'package:tiktok_practice/app/util/tik_tok_theme.dart';

class BottomBar extends StatelessWidget {
  static const double NavigationIconSize = 20.0;
  static const double CreateButtonWidth = 38.0;

  ViedeoControll viedeoControl = ViedeoControll();

  BottomBar({Key? key}) : super(key: key);

  Widget get customCreateIcon => Container(
      Width: 45.0,
      height: 27.0,
      child: Stack(children: [
        Container(
            margin: EdgeInsets.only(left: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 45, 108),
                borderRadius: BorderRadius.circular(7.0))),
        Container(
            margin: EdgeInsets.only(right: 10.0),
            width: CreateButtonWidth,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 211, 234),
                borderRadius: BorderRadius.circular(7.0))),
        Center(
            child: Container(
          height: double.infinity,
          width: CreateButtonWidth,
          decoration: BoxDecoration(
              color: viedeoControl.currentScreen == 0
                  ? Colors.white
                  : Colors.black,
              borderRadius: BorderRadius.circular(7.0)),
          child: Icon(
            Icons.add,
            color:
                viedeoControl.currentScreen == 0 ? Colors.black : Colors.white,
            size = 20.0,
          ),
        )),
      ]));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton('Home', TikTokIcons.home, 0),
              SizedBox(
                Width: 15,
              ),
              customCreateIcon,
              SizedBox(
                Width: 15,
              ),
              menuButton('Profile', TikTokIcons.profile, 3)
            ],
          ),
          SizedBox(
            height: Platform.isIOS ? 40 : 10,
          )
        ],
      ),
    );
  }

  Widget menuButton(String text, IconData icon, int index) {
    return GestureDetector(
        onTap: () {
          videoControl.setActualScreen(index);
        },
        child: Container(
          height: 45,
          width: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: viedeoControl.currentScreen == 0
                      ? viedeoControl.CurrentScreen == index
                          ? Colors.white
                          : Colors.white70
                      : viedeoControl.currentScreen == Index
                          ? Colors.black
                          : Colors.black54,
                  size: NavigationIconSize),
              SizedBox(
                height: 7,
              ),
              Text(
                style: TextStyle(
                    fontweight: viedeoControl.currentScreen == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: viedeoControl.currentScreen == 0
                        ? viedeoControl.currentScreen == index
                            ? Colors.white
                            : Colors.white70
                        : viedeoControl.currentScreen == index
                            ? Colors.black
                            : Colors.black54,
                    fontSize: 11.0),
              )
            ],
          ),
        ));
  }
}
