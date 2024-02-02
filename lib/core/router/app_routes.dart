import 'package:flutter/material.dart';

/// an [immutable] class is the one whose instances
///cannot be modified once they are created
///
/// an [abstract] class enforces that extended class
/// are also immutable

@immutable
abstract class AppRoutes {
  const AppRoutes._();

  /// [Routing_paths]
  static const String root = '/root';

  static const String watch = '/watch';
  static const String dashboard = '/dashboard';
  static const String mediaLibrary = '/mediaLibrary';
  static const String more = '/more';
  static const String movieDetails = '/movieDetails';
  static const String seatMapping = '/seatMapping';
  static const String viewTrailor = '/viewTrailor';
}
