import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.buttonTitle,
    required this.onTap,
    this.color,
    this.shadowColor,
    this.height,  
    this.width,
    super.key,
  });

  final String buttonTitle;
  final Color? color;
  final Color? shadowColor;
  final double? height;
  final double? width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: Container(
        height: height ?? 45.h,
        width: width ?? 1.sw - 130.w,
        decoration: BoxDecoration(
          color: color ?? kBlueColor,
          borderRadius: BorderRadius.circular(10.r),
        ), 
        
        child: Center(
          child: Text(
            buttonTitle,
            style: kPoppins600s14px,
          ),
        ),
      ),
    );
  }
}
