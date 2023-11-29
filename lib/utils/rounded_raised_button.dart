// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jartech_app/constants/app_colors.dart';


class ElevateButton extends StatelessWidget {


  String? label = "";
  final Function()? onPressAction;
  Color? btnColor;

  ElevateButton({required this.label, this.btnColor, required this.onPressAction});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
       width: 150.w,
       height: 50.h,
      child: ElevatedButton(
        onPressed: onPressAction,
        child:  Text(
            label!,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15)
        ),
        style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appMaterialColor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
  ),
      ),
    );
  }
}