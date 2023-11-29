import 'package:flutter/material.dart';
import 'package:jartech_app/constants/app_images.dart';

AppBar appBarmenu(
    {required BuildContext context,
   required String title,
    Color? color,
    List<Widget>? action,
    double elevation = 0,
    Color iconColor = Colors.black,
    Color? bgClr}) {
  return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: bgClr,
      centerTitle: true,
      elevation: elevation,
      actions: action,
      leading:InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Image.asset(
          AppImages.arrow,
          color: iconColor,
        ),
      )
      // automaticallyImplyLeading: false,
      );
}
