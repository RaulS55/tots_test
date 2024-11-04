import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

/// Gets the screen dimensions
class Responsive {
  late double _width, _height, _diagonal;
  // True if it's a tablet
  late bool _isTablet;

  Responsive(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt(size.width * size.width + size.height * size.height);
    _isTablet = size.shortestSide >= 600;
  }

  /// Returns the screen width
  double get width => _width;

  /// Returns the screen height
  double get height => _height;

  /// Returns the screen diagonal
  double get diagonal => _diagonal;

  /// Returns true if the device is a tablet
  bool get isTablet => _isTablet;

  static Responsive of(BuildContext context) => Responsive(context);

  /// Returns the screen width as a percentage
  double wp(double percent) => _width * percent / 100;

  /// Returns the screen height as a percentage
  double hp(double percent) => _height * percent / 100;

  /// Returns the screen diagonal as a percentage
  double dp(double percent) => _diagonal * percent / 100;
}