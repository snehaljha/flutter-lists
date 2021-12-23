import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

@immutable
// ignore: must_be_immutable
class AppColors {
  //page components
  Color pageTitleText = Colors.white;
  MaterialColor primaryColor = Colors.deepOrange;
  Color pageBackground = Colors.white70;

  //lists component
  Color renameActionBackground = Colors.yellowAccent;
  Color actionForeground = Colors.black;
  Color deleteActionBackround = Colors.redAccent;
  Color listTitlesColor = Colors.black;
  Color listTitlesBGColor = Colors.white;

  //task adding screen
  Color textAdderButtonText = Colors.white;
  Color tasksTextColor = Colors.black;
  Color tasksBGColor = Colors.white;

  AppColors() {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    bool isDark = brightness == Brightness.dark;
    if (isDark) {
      //page components
      pageTitleText = Colors.black;
      primaryColor = Colors.deepOrange;
      pageBackground = Colors.black;

      //lists component
      renameActionBackground = Colors.yellowAccent;
      actionForeground = Colors.black;
      deleteActionBackround = Colors.redAccent;
      listTitlesColor = Colors.white70;
      listTitlesBGColor = Colors.white24;

      //task adding screen
      textAdderButtonText = Colors.black;
      tasksTextColor = Colors.white70;
      tasksBGColor = Colors.white24;
    }
  }
}
