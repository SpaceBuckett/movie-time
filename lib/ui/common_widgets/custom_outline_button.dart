import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    required this.buttonTitle,
    required this.onTap,
    this.borderColor,
    this.iconUrl,
    this.height,
    this.width,
    this.fontColor,
    this.iconColor,
    super.key,
  });

  final Color? borderColor;
  final double? height;
  final double? width;
  final String? iconUrl;
  final String buttonTitle;
  final VoidCallback onTap;
  final Color? fontColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: Container(
          height: height ?? 45.h,
          width: width ?? 1.sw - 130.w,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor ?? kBlueColor,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconUrl != null)
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Image.asset(
                      iconUrl!,
                      height: 12.h,
                      width: 8.h,
                      fit: BoxFit.contain,
                      color: iconColor,
                    ),
                  ),
                Text(
                  buttonTitle,
                  style: kPoppins600s14px,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
