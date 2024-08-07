// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon {
  // other icons
  static Widget get splash_logo =>
      SvgPicture.asset('assets/icon/other/splash_logo.svg',
          fit: BoxFit.scaleDown);

  // bottom navigation bar icons
  static Widget get gnb_camera_24_actived =>
      SvgPicture.asset('assets/icon/24/gnb_part/camera_24_actived.svg',
          fit: BoxFit.scaleDown);
  static Widget get gnb_camera_24_inactived =>
      SvgPicture.asset('assets/icon/24/gnb_part/camera_24_inactived.svg',
          fit: BoxFit.scaleDown);
  static Widget get gnb_flag_24_actived =>
      SvgPicture.asset('assets/icon/24/gnb_part/flag_24_actived.svg',
          fit: BoxFit.scaleDown);
  static Widget get gnb_flag_24_inactived =>
      SvgPicture.asset('assets/icon/24/gnb_part/flag_24_inactived.svg',
          fit: BoxFit.scaleDown);
  static Widget get gnb_map_24_actived =>
      SvgPicture.asset('assets/icon/24/gnb_part/map_24_actived.svg',
          fit: BoxFit.scaleDown);
  static Widget get gnb_map_24_inactived =>
      SvgPicture.asset('assets/icon/24/gnb_part/map_24_inactived.svg',
          fit: BoxFit.scaleDown);
  static Widget get gnb_userprofile_24_actived =>
      SvgPicture.asset('assets/icon/24/gnb_part/userprofile_24_actived.svg',
          fit: BoxFit.scaleDown);
  static Widget get gnb_userprofile_24_inactived =>
      SvgPicture.asset('assets/icon/24/gnb_part/userprofile_24_inactived.svg',
          fit: BoxFit.scaleDown);

  // 24 Size Icon
  static Widget get search_24 =>
      SvgPicture.asset('assets/icon/24/search_24.svg', fit: BoxFit.scaleDown);
  static Widget get pin_red_24 =>
      SvgPicture.asset('assets/icon/24/pin_red_24.svg', fit: BoxFit.scaleDown);
  static Widget get pin_blue_24 =>
      SvgPicture.asset('assets/icon/24/pin_blue_24.svg', fit: BoxFit.scaleDown);
  static Widget get x_circle_24 =>
      SvgPicture.asset('assets/icon/24/x_circle_24.svg', fit: BoxFit.scaleDown);
  static Widget get arrow_left_24 =>
      SvgPicture.asset('assets/icon/24/arrow_left_24.svg',
          fit: BoxFit.scaleDown);
  static Widget get x_24 =>
      SvgPicture.asset('assets/icon/24/x_24.svg', fit: BoxFit.scaleDown);

  // 16 Size Icon
  static Widget get plus_16 =>
      SvgPicture.asset('assets/icon/16/plus_16.svg', fit: BoxFit.scaleDown);

  // 40 Size Icon
  static Widget get gps_40 =>
      SvgPicture.asset('assets/icon/40/gps_40.svg', fit: BoxFit.scaleDown);
}
