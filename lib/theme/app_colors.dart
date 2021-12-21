import 'package:flutter/material.dart';

@immutable
class AppColors {
  const AppColors();
  //page components
  final Color pageTitleText = const Color(0x000000ff);

  //lists component
  final Color renameActionBackground = const Color(0x888888ff);
  final Color actionForeground = const Color(0x000000ff);
  final Color deleteActionBackround = const Color(0xff3333ff);
  final Color listTitlesColor = Colors.black;

  //task adding screen
  final Color textAdderButtonText = Colors.black;
  final Color tasksTextColor = Colors.black;
}
