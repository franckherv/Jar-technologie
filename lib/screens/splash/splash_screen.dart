// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jartech_app/constants/app_style.dart';

import '../../constants/app_colors.dart';

class SplashScreen extends StatefulWidget {
  Color? backgroundColor = Colors.white;
  TextStyle? styleTextUnderTheLoader = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);
  final List<Future>? initialFutures;
   SplashScreen({super.key, this.initialFutures});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //? time to display splash screen
  final splashDelay = 3;


  @override
  void initState() {
    super.initState();
    _loadWidget();
  }


  _loadWidget() async {
    var beginAt = DateTime.now();
    var second = 0;
    Duration duration;
    second = DateTime.now().difference(beginAt).inSeconds;
    if (second > splashDelay) {
      duration = const Duration(milliseconds: 100);
    } else {
      duration = Duration(seconds: splashDelay - second);
    }

    return Timer(duration, navigationPage);
  }

  

  Future<void> navigationPage() async {
      Navigator.of(context).pushNamedAndRemoveUntil('/home-screen', (Route<dynamic> route) => false);
  }

 

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.appThemeColor,
        body: Center(child: Text("LOGO", style: AppStyle.whiteBoldSz12,),)
      ),
    );
  }

 
}
