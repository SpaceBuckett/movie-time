import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tentwenty_assignment/core/router/app_routes.dart';
import 'package:tentwenty_assignment/ui/screens/dashboard/dashboard_screen.dart';
import 'package:tentwenty_assignment/ui/screens/media_library/media_library_screen.dart';
import 'package:tentwenty_assignment/ui/screens/more/more_screen.dart';
import 'package:tentwenty_assignment/ui/screens/movie_details/movie_details_screen.dart';
import 'package:tentwenty_assignment/ui/screens/root/root_screen.dart';
import 'package:tentwenty_assignment/ui/screens/seat_selection/seat_selection_screen.dart';
import 'package:tentwenty_assignment/ui/screens/watch/watch_screen.dart';

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _navigatorKey,
  initialLocation: AppRoutes.root,
  routes: [
    GoRoute(
      path: AppRoutes.movieDetails,
      name: 'movieDetails',
      parentNavigatorKey: _navigatorKey,
      builder: (context, state) {
        return const MovieDetailsScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.root,
      name: 'root',
      parentNavigatorKey: _navigatorKey,
      builder: (context, state) {
        return const RootScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.seatMapping,
      name: 'seatMapping',
      parentNavigatorKey: _navigatorKey,
      builder: (context, state) {
        return const SeatingMapScreen();
      },
    ),
    // GoRoute(
    //   path: AppRoutes.auth,
    //   name: 'auth',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) {
    //     return const OnBoardingAuthScreen().animate().fadeIn(
    //           duration: 300.ms,
    //         );
    //   },
    // ),
    // // GoRoute(
    // //   path: AppRoutes.home,
    // //   name: 'home',
    // //   parentNavigatorKey: _navigatorKey,
    // //   builder: (context, state) {
    // //     return const Home();
    // //   },
    // // ),
    // // GoRoute(
    // //   path: AppRoutes.userProfile,
    // //   name: 'userProfile',
    // //   parentNavigatorKey: _navigatorKey,
    // //   builder: (context, state) {
    // //     return const UserProfileScreen();
    // //   },
    // // ),

    // GoRoute(
    //   path: AppRoutes.faqs,
    //   name: 'faqs',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) {
    //     return const FAQsScreen();
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.contacts,
    //   name: 'contacts',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) {
    //     return const ContactUsScreen();
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.imageScanner,
    //   name: 'imageScanner',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) {
    //     Map<String, dynamic> arg = state.extra as Map<String, dynamic>;

    //     return ImageScannerScreen(
    //       imagePath: arg['imagePath'],
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.details,
    //   name: 'details',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) {
    //     Map<String, dynamic> arg = state.extra as Map<String, dynamic>;

    //     return DetailsScreen(
    //       imagePath: arg['imagePath'],
    //       yourCoral: arg['yourCarol'],
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.savedCarols,
    //   name: 'yourCarols',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) {
    //     Map<String, dynamic> arg = state.extra as Map<String, dynamic>;

    //     return YourCoralsScreen(
    //       category: arg['category'],
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.home,
    //   name: 'home',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) => const Home(),
    // ),
    // GoRoute(
    //   path: AppRoutes.root,
    //   name: 'root',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) {
    //     return const RootScreen();
    //   },
    // ),
    // GoRoute(
    //   path: AppRoutes.home,
    //   name: 'vendorMoreInfo',
    //   parentNavigatorKey: _navigatorKey,
    //   builder: (context, state) {
    //     return const HomeScreen();
    //   },
    // ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return const RootScreen();
      },
      routes: [
        GoRoute(
          path: AppRoutes.dashboard,
          name: 'dashboard',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const DashboardScren(),
        ),
        GoRoute(
          path: AppRoutes.watch,
          name: 'watch',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const WatchScreen(),
        ),
        GoRoute(
          path: AppRoutes.mediaLibrary,
          name: 'mediaLibrary',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const MediaLibraryScreen(),
        ),
        GoRoute(
          path: AppRoutes.more,
          name: 'more',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const MoreScreen(),
        ),
      ],
    ),
    // GoRoute(
    //   path: AppRoutes.orderHistoryPath,
    //   name: 'orderHistory',
    //   parentNavigatorKey: _shellNavigatorKey,
    //   builder: (context, state) => OrderHistoryScreen(),
    // ),
    // GoRoute(
    //   path: AppRoutes.userAccountPath,
    //   name: 'userAccount',
    //   parentNavigatorKey: _shellNavigatorKey,
    //   builder: (context, state) => AccountScreen(),
    // ),
  ],
);

GoRouter get _router => router;
BuildContext? get getContext =>
    _router.routerDelegate.navigatorKey.currentContext;
