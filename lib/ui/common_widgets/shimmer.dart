import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({
    this.height,
    this.width,
    super.key,
  });

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.h,
      width: width ?? 1.sw,
      decoration: BoxDecoration(
          color: kGrey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10.r)),
    ).animate(onPlay: (controller) => controller.repeat()).shimmer();
  }
}
