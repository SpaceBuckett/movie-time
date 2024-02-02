import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/core/data_models/date_selection.dart';
import 'package:tentwenty_assignment/core/data_models/hall_selection.dart';
import 'package:tentwenty_assignment/core/data_models/movie.dart';
import 'package:tentwenty_assignment/core/router/app_router.dart';
import 'package:tentwenty_assignment/core/theme/app_icons.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/core/theme/font_styles.dart';
import 'package:tentwenty_assignment/ui/common_widgets/custom_elevated_button.dart';
import 'package:tentwenty_assignment/ui/screens/seat_selection/seat_selection_viewmodel.dart';

class SeatingMapScreen extends StatelessWidget {
  const SeatingMapScreen({
    required this.movie,
    super.key,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SeatingViewModel(),
      child: Consumer<SeatingViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: kScaffoldBackground,
          appBar: _topBar(
            movie: movie,
            model: model,
          ),
          body: AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            firstChild: const CinemaHallAndTimeSelection(),
            secondChild: const PaymentSection(),
            crossFadeState: !model.isPaymentSheetActive
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
        ),
      ),
    );
  }

  AppBar _topBar({required Movie movie, required SeatingViewModel model}) {
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
                    movie.title,
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
                model.isAbleToProceed()
                    ? '${model.choosenDate?.date}, 2024 | ${model.choosenHall?.name}'
                    : 'In Theaters ${model.formatDate(movie.releaseDate)}',
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

class CinemaHallAndTimeSelection extends StatelessWidget {
  const CinemaHallAndTimeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SeatingViewModel>(
      builder: (context, model, child) => Container(
        height: 1.sh,
        width: 1.sw,
        color: kScaffoldBackground,
        child: Padding(
          padding: EdgeInsets.only(bottom: 26.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DateSelection(),
              SizedBox(height: 15.h),
              const SizedBox(
                height: 32,
              ),
              const CinemaHallSelection(),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomElevatedButton(
                  buttonTitle: 'Select Seats',
                  width: 323.w,
                  color: model.isAbleToProceed()
                      ? kBlueColor
                      : kBlueColor.withOpacity(0.3),
                  onTap: () {
                    model.togglePaymentSection();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SeatingViewModel>(
      builder: (context, model, child) => Container(
        height: 1.sh,
        width: 1.sw,
        color: kScaffoldBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60.h),
            Stack(
              children: [
                SvgPicture.asset(
                  AppIcons.largeScreenOverlay,
                ),
                Positioned(
                  top: 10.h,
                  left: 130.w,
                  right: 130.w,
                  child: Text(
                    "SCREEN",
                    style: kBody500.copyWith(fontSize: 8.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.5.h),
            const SelectedHallSettingView(),
            const Spacer(),
            Container(
              height: 252.h,
              width: 1.sw,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 21.0.w,
                  vertical: 26.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SeatIconsGuide(),
                    SizedBox(height: 32.h),
                    const SeatingNumberButton(),
                    const Spacer(),
                    Row(
                      children: [
                        const PaymentButton(),
                        const Spacer(),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          firstChild: CustomElevatedButton(
                            width: 216.w,
                            height: 50.h,
                            buttonTitle: 'Proceed to pay',
                            onTap: () {
                              model.proceedToPayment();
                            },
                          ),
                          secondChild: SizedBox(
                            width: 216,
                            height: 50.h,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: kBlueColor,
                              ),
                            ),
                          ),
                          crossFadeState: !model.isProcessingPayment
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 108.w,
      decoration: BoxDecoration(
        color: kGrey.withOpacity(0.10),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0.w,
          top: 7.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Price',
              style: kBody.copyWith(
                fontSize: 10.sp,
                height: 0.9,
                color: kDarkText,
              ),
            ),
            Text(
              '\$50',
              style: kPoppins600s14px.copyWith(
                fontSize: 16.sp,
                color: kDarkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SeatingNumberButton extends StatelessWidget {
  const SeatingNumberButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 97.w,
      padding: EdgeInsets.symmetric(
        horizontal: 9.8.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFA6A6A6).withOpacity(0.10),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '4 /',
            style: kBody500.copyWith(
              fontSize: 14.sp,
              color: kDarkText,
            ),
          ),
          Text(
            '3 row',
            style: kBody.copyWith(
              fontSize: 10.sp,
              color: kDarkText,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.close_rounded,
            color: kDarkText,
            size: 12.73.w,
          )
        ],
      ),
    );
  }
}

class SeatIconsGuide extends StatelessWidget {
  const SeatIconsGuide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SeatIcon(
              icon: AppIcons.selectedSeatIcon,
              text: 'Selected',
            ),
            SizedBox(height: 15.h),
            const SeatIcon(
              icon: AppIcons.vipSeatIcon,
              text: 'VIP (150\$)',
            ),
          ],
        ),
        SizedBox(width: 50.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SeatIcon(
              icon: AppIcons.seatNotAvailableIcon,
              text: 'Not available',
            ),
            SizedBox(height: 15.h),
            const SeatIcon(
              icon: AppIcons.regularSeat,
              text: 'Regular (50\$)',
            ),
          ],
        ),
      ],
    );
  }
}

class SeatIcon extends StatelessWidget {
  const SeatIcon({
    required this.icon,
    required this.text,
    super.key,
  });
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          height: 16.16.h,
          width: 17.01.w,
        ),
        10.horizontalSpace,
        Text(
          text,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class SelectedHallSettingView extends StatelessWidget {
  const SelectedHallSettingView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SeatingViewModel>(
      builder: (context, model, child) => SizedBox(
        height: 200.h,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: 23.w),
          child: SeatLayoutWidget(
            onSeatStateChanged: model.onSeatStateChanged,
            stateModel: SeatLayoutStateModel(
              rows: 10,
              cols: 26,
              seatSvgSize: 13,
              pathSelectedSeat: AppIcons.selectedSeatIcon,
              pathDisabledSeat: AppIcons.seatNotAvailableIcon,
              pathSoldSeat: AppIcons.vipSeatIcon,
              pathUnSelectedSeat: AppIcons.regularSeat,
              currentSeatsState: model.selectedHallSeatArrangement,
            ),
          ),
        ),
      ),
    );
  }
}

class CinemaHallSelection extends StatelessWidget {
  const CinemaHallSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SeatingViewModel>(
      builder: (context, model, child) => SizedBox(
        height: 300.h,
        child: ListView.builder(
          padding: EdgeInsets.only(left: 20.w),
          itemCount: model.availableHalls.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return CinemaHallTile(
              cinemaHall: model.availableHalls[index],
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class CinemaHallTile extends StatelessWidget {
  const CinemaHallTile({
    required this.cinemaHall,
    required this.index,
    super.key,
  });

  final CinemaHall cinemaHall;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<SeatingViewModel>(
      builder: (context, model, child) => Padding(
        padding: EdgeInsets.only(right: 10.0.w),
        child: SizedBox(
          width: 249.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    cinemaHall.timing,
                    style: kBody500.copyWith(color: kDarkText),
                  ),
                  SizedBox(width: 9.w),
                  Text(
                    cinemaHall.name,
                    style: kBody,
                  )
                ],
              ),
              SizedBox(height: 5.h),
              InkWell(
                onTap: () {
                  model.selectHall(index);
                },
                child: Stack(
                  children: [
                    Container(
                      height: 145.h,
                      width: 249.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 52.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: kScaffoldBackground,
                        border: Border.all(
                          color: cinemaHall.isSelected ?? false
                              ? kBlueColor
                              : kGrey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          if (cinemaHall.isSelected ?? false)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 4.r,
                              offset: const Offset(0, 0),
                            )
                        ],
                      ),
                      child: FittedBox(
                        child: SeatLayoutWidget(
                          onSeatStateChanged: model.onSeatStateChanged,
                          stateModel: SeatLayoutStateModel(
                            rows: 14,
                            cols: 24,
                            seatSvgSize: 5,
                            pathSelectedSeat: 'assets/icons/selected_seat.svg',
                            pathDisabledSeat:
                                'assets/icons/not_available_seat.svg',
                            pathSoldSeat: 'assets/icons/vip_seat.svg',
                            pathUnSelectedSeat: 'assets/icons/regular_seat.svg',
                            currentSeatsState: model.seatArrangement,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 52.w,
                      right: 52.w,
                      top: 16.h,
                      child: SvgPicture.asset(
                        'assets/icons/screen_display_overlay.svg',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              RichText(
                text: TextSpan(
                  text: 'From ',
                  style: kBody500,
                  children: <TextSpan>[
                    TextSpan(
                      text: '${cinemaHall.cost}\$',
                      style: kBody500.copyWith(
                        fontWeight: FontWeight.w700,
                        color: kDarkText,
                      ),
                    ),
                    const TextSpan(text: ' or '),
                    TextSpan(
                      text: '${cinemaHall.bonus} bonus',
                      style: kBody500.copyWith(
                        fontWeight: FontWeight.w700,
                        color: kDarkText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateSelection extends StatelessWidget {
  const DateSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SeatingViewModel>(
      builder: (context, model, child) => Column(
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
          ),
        ],
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
