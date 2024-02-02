import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tentwenty_assignment/core/data_models/movie.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';

class OverviewSection extends StatelessWidget {
  const OverviewSection({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: kPoppins500s16px.copyWith(
                color: kDarkText,
              ),
            ),
            SizedBox(height: 14.h),
            Text(
              movie.overview,
              style: kBody,
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
