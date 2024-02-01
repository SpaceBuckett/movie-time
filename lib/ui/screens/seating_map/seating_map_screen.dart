import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/core/data_models/date_selection.dart';
import 'package:tentwenty_assignment/core/router/app_router.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';
import 'package:tentwenty_assignment/ui/screens/seating_map/seating_map_viewmodel.dart';

class SeatingMapScreen extends StatelessWidget {
  const SeatingMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SeatingViewModel(),
      child: Consumer<SeatingViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: kScaffoldBackground,
          appBar: _topBar(),
          body: Container(
            height: 1.sh,
            width: 1.sw,
            color: kScaffoldBackground,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0.w, top: 94.h),
                    child: Text(
                      'Date',
                      style: kPoppins500s16px.copyWith(
                        color: kDarkText,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(
                    height: 32.h,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 20.w),
                      itemCount: model.availableDates.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomChipButton(
                          date: model.availableDates[index],
                          onTap: () {
                            model.chooseDate(index);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _topBar() {
    return AppBar(
      toolbarHeight: 98.h,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20.0.w, right: 20.w, bottom: 15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      GoRouter.of(getContext!).pop();
                    },
                    child: Image.asset(
                      'assets/icons/back-icon.png',
                      height: 30.h,
                      width: 30.h,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "The King's Man",
                    style: kPoppins500s16px.copyWith(
                      color: kDarkText,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                    width: 30.h,
                  ),
                ],
              ),
              Text(
                'In Theaters December 22, 2021',
                style: kBody500.copyWith(
                  color: kBlueColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomChipButton extends StatelessWidget {
  const CustomChipButton({
    required this.date,
    required this.onTap,
    super.key,
  });

  final Date date;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.r),
        onTap: onTap,
        child: Container(
          height: 32.h,
          decoration: BoxDecoration(
            color: date.isActive ?? false
                ? kBlueColor
                : kNonActiveGrey.withOpacity(0.10),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              if (date.isActive ?? false)
                BoxShadow(
                  color: kBlueColor.withOpacity(0.27),
                  spreadRadius: 0,
                  blurRadius: 21.r,
                  offset: const Offset(0, 0),
                )
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Center(
              child: Text(
                date.date,
                style: kPoppins600s14px.copyWith(
                  fontSize: 12.sp,
                  color: date.isActive ?? false ? Colors.white : kDarkText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
