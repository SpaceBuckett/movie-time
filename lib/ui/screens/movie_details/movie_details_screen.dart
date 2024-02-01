import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tentwenty_assignment/core/constants/strings.dart';
import 'package:tentwenty_assignment/core/router/app_routes.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';
import 'package:tentwenty_assignment/ui/common_widgets/custom_elevated_button.dart';
import 'package:tentwenty_assignment/ui/common_widgets/custom_outline_button.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          CustomSliverAppBar(),
          GeneraSection(),
          SliverDivider(),
          OverviewSection(),
        ],
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      automaticallyImplyLeading: false,
      expandedHeight: 466.0.h,
      flexibleSpace: Stack(
        children: [
          Container(
            height: 495.h,
            color: Colors.blueAccent,
          ),
          const ShadowOverlay(),
          Center(
            child: FlutterLogo(size: 400.h),
          ),
          const BackButton(),
          const ReleaseDateTicketsAndTrailerButtons(),
        ],
      ),
    );
  }
}

class ShadowOverlay extends StatelessWidget {
  const ShadowOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: 1.sw,
        height: 459.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              const Color(0xFF000000).withOpacity(0.5),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class OverviewSection extends StatelessWidget {
  const OverviewSection({
    super.key,
  });

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
              dummyOverView,
              style: kBody,
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}

class SliverDivider extends StatelessWidget {
  const SliverDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.fromLTRB(40.w, 22.h, 40.w, 15.h),
        child: Divider(
          color: Colors.black.withOpacity(0.05),
        ),
      ),
    );
  }
}

class GeneraSection extends StatelessWidget {
  const GeneraSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 40.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 27.h),
            Text(
              'Genres',
              style: kPoppins500s16px.copyWith(
                color: kDarkText,
              ),
            ),
            SizedBox(height: 14.h),
            Wrap(
              spacing: 5.0.w,
              runSpacing: 3.0.w,
              children: List.generate(
                5,
                (index) => const GenreChip(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReleaseDateTicketsAndTrailerButtons extends StatelessWidget {
  const ReleaseDateTicketsAndTrailerButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: FittedBox(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 287.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'In Theaters December 22, 2021',
                  style: kPoppins500s16px,
                ),
                SizedBox(height: 15.h),
                CustomElevatedButton(
                  buttonTitle: 'Get Tickets',
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.seatMapping);
                  },
                ),
                SizedBox(height: 10.h),
                CustomOutlineButton(
                  buttonTitle: 'Watch Trailer',
                  iconUrl: 'assets/icons/play-button-icon.png',
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 59.h,
      left: 13.w,
      child: InkWell(
        onTap: () {
          GoRouter.of(context).pop();
        },
        child: Row(
          children: [
            Image.asset(
              'assets/icons/back-icon.png',
              height: 30.h,
              width: 30.h,
            ),
            SizedBox(width: 15.w),
            Text(
              'Watch',
              style: kPoppins500s16px,
            ),
          ],
        ),
      ),
    );
  }
}

class GenreChip extends StatelessWidget {
  const GenreChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xFF15D2BC),
      ),
      child: Text(
        'Action',
        style: kPoppins600s14px.copyWith(
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
