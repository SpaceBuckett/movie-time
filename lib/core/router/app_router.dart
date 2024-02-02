import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tentwenty_assignment/core/router/app_routes.dart';
import 'package:tentwenty_assignment/ui/screens/dashboard/dashboard_screen.dart';
import 'package:tentwenty_assignment/ui/screens/media_library/media_library_screen.dart';
import 'package:tentwenty_assignment/ui/screens/more/more_screen.dart';
import 'package:tentwenty_assignment/ui/screens/movie_details/movie_details_screen.dart';
import 'package:tentwenty_assignment/ui/screens/movie_details/trailer_player/trailer_player_screen.dart';
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
        Map<String, dynamic> arg = state.extra as Map<String, dynamic>;
        return MovieDetailsScreen(
          movie: arg['movie'],
        );
      },
    ),
    GoRoute(
      path: AppRoutes.viewTrailor,
      name: 'viewTrailor',
      parentNavigatorKey: _navigatorKey,
      builder: (context, state) {
        Map<String, dynamic> arg = state.extra as Map<String, dynamic>;
        return ViewTrailorScreen(
          trailorId: arg['trailorId'],
        );
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
        Map<String, dynamic> arg = state.extra as Map<String, dynamic>;

        return SeatingMapScreen(
          movie: arg['movie'],
        );
      },
    ),
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
  ],
);

GoRouter get _router => router;
BuildContext? get getContext =>
    _router.routerDelegate.navigatorKey.currentContext;
