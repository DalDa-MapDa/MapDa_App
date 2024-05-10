// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon {
  // other icons
  static Widget get splash_logo =>
      SvgPicture.asset('assets/icon/other/splash_logo.svg',
          fit: BoxFit.scaleDown);
}
