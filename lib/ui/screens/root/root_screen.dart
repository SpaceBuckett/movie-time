import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tentwenty_assignment/core/theme/colors.dart';
import 'package:tentwenty_assignment/ui/screens/root/root_viewmodel.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RootViewModel(),
      child: Consumer<RootViewModel>(
        builder: (context, model, child) => Scaffold(
          body: model.screens[model.activePageIndex],
          backgroundColor: kScaffoldBackground,
          bottomNavigationBar: BottomNavBar(
            bottomBarItems: [
              BottomBarItem(
                label: 'Dashboard',
                iconPath: 'assets/icons/dashboard-icon.png',
                isActive: model.activePageIndex == 0,
                onTap: () {
                  model.updateActivePageIndex(pageIndex: 0);
                },
              ),
              BottomBarItem(
                label: 'Watch',
                iconPath: 'assets/icons/watch-icon.png',
                isActive: model.activePageIndex == 1,
                onTap: () {
                  model.updateActivePageIndex(pageIndex: 1);
                },
              ),
              BottomBarItem(
                label: 'Media Library',
                iconPath: 'assets/icons/media-library-icon.png',
                isActive: model.activePageIndex == 2,
                onTap: () {
                  model.updateActivePageIndex(pageIndex: 2);
                },
              ),
              BottomBarItem(
                label: 'More',
                iconPath: 'assets/icons/hamburger-icon.png',
                isActive: model.activePageIndex == 3,
                onTap: () {
                  model.updateActivePageIndex(pageIndex: 3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.bottomBarItems,
    super.key,
  });

  final List<Widget> bottomBarItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78.h,
      width: 1.sw,
      decoration: BoxDecoration(
        color: kBlackColor,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(26.w, 17.h, 25.w, 18.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bottomBarItems,
        ),
      ),
    );
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    required this.iconPath,
    required this.label,
    required this.onTap,
    this.isActive,
    super.key,
  });

  final String iconPath;
  final String label;
  final VoidCallback onTap;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 48.h,
        width: 75.w,
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomBarIcon(
              iconPath: iconPath,
              isActive: isActive ?? false,
            ),
            BottomBarLabel(
              label: label,
              isActive: isActive ?? false,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomBarLabel extends StatelessWidget {
  const BottomBarLabel({
    required this.label,
    required this.isActive,
    super.key,
  });

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: 'Roboto',
        color: isActive ? Colors.white : kNonActiveGrey,
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        height: 1.h,
      ),
    );
  }
}

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    required this.iconPath,
    required this.isActive,
    super.key,
  });

  final String iconPath;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Consumer<RootViewModel>(
        builder: (context, model, child) => SizedBox(
              height: 24.h,
              width: 24.w,
              child: Center(
                child: Image.asset(
                  iconPath,
                  height: 16.h,
                  width: 16.h,
                  color: isActive ? Colors.white : kNonActiveGrey,
                ),
              ),
            )
        // .animate(
        //   target: isActive ? 1.2 : 0.8,
        // )
        // .shimmer()
        // .then()
        // .scale(
        //   curve: Curves.easeInOut,
        //   begin: const Offset(0.5, 0.5),
        //   end: const Offset(1.0, 1.0),
        // ),
        );
  }
}
