// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon {
  // other icons
  static Widget get splash_logo =>
      SvgPicture.asset('assets/icon/other/splash_logo.svg',
          fit: BoxFit.scaleDown);
  static Widget get restroom =>
      SvgPicture.asset('assets/icon/other/restroom.svg', fit: BoxFit.scaleDown);
  static Widget get elevator =>
      SvgPicture.asset('assets/icon/other/elevator.svg', fit: BoxFit.scaleDown);
  static Widget get ramp =>
      SvgPicture.asset('assets/icon/other/ramp.svg', fit: BoxFit.scaleDown);
  static Widget get kakao_logo =>
      SvgPicture.asset('assets/icon/other/kakao_logo.svg',
          fit: BoxFit.scaleDown);
  static Widget get apple_logo_black =>
      SvgPicture.asset('assets/icon/other/apple_logo_black.svg',
          fit: BoxFit.scaleDown);
  static Widget get apple_logo_white =>
      SvgPicture.asset('assets/icon/other/apple_logo_white.svg',
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
  static Widget get image_add_24 =>
      SvgPicture.asset('assets/icon/24/image_add_24.svg',
          fit: BoxFit.scaleDown);
  static Widget get x_redcircle_24 =>
      SvgPicture.asset('assets/icon/24/x_redcircle_24.svg',
          fit: BoxFit.scaleDown);
  static Widget get marker_blue_24 => SvgPicture.asset(
        'assets/icon/24/marker_blue_24.svg',
      );
  static Widget get marker_red_24 => SvgPicture.asset(
        'assets/icon/24/marker_red_24.svg',
      );

  // 16 Size Icon
  static Widget get plus_white_16 =>
      SvgPicture.asset('assets/icon/16/plus_white_16.svg',
          fit: BoxFit.scaleDown);
  static Widget get plus_dark_16 =>
      SvgPicture.asset('assets/icon/16/plus_dark_16.svg',
          fit: BoxFit.scaleDown);

  // 40 Size Icon
  static Widget get gps_40 =>
      SvgPicture.asset('assets/icon/40/gps_40.svg', fit: BoxFit.scaleDown);

  //PNG Icon
  static Widget get pin_red =>
      Image.asset('assets/icon/png/pin_red.png', fit: BoxFit.scaleDown);
  static Widget get pin_blue =>
      Image.asset('assets/icon/png/pin_blue.png', fit: BoxFit.scaleDown);
}
