import 'package:flutter/material.dart';
import 'package:tentwenty_assignment/core/utils/base_viewmodel.dart';
import 'package:tentwenty_assignment/ui/screens/dashboard/dashboard_screen.dart';
import 'package:tentwenty_assignment/ui/screens/media_library/media_library_screen.dart';
import 'package:tentwenty_assignment/ui/screens/more/more_screen.dart';
import 'package:tentwenty_assignment/ui/screens/watch/watch_screen.dart';

class RootViewModel extends BaseViewModel {
  int activePageIndex = 0;
  bool initAnimate = false;

  List<Widget> screens = [
    const DashboardScren(),
    const WatchScreen(),
    const MediaLibraryScreen(),
    const MoreScreen(),
  ];

  updateActivePageIndex({required int pageIndex}) {
    activePageIndex = pageIndex;
    notifyListeners();
  }

  toggleAnimation() {
    initAnimate = !initAnimate;
    notifyListeners();
  }
}
