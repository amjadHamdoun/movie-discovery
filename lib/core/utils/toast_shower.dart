
import 'package:fh/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'enums.dart';

class ToastShower {
  final GlobalKey<ScaffoldMessengerState> snakeBarKey = GlobalKey<ScaffoldMessengerState>();

  void showToast(final String message, final ToastType type, BuildContext context) {
    late Color backgroundColor, fontColor;
    late IconData iconData;

    switch (type) {
      case ToastType.success:
        backgroundColor = AppColors.green;
        fontColor = AppColors.white;
        iconData = Icons.check_circle_outline;
        break;
      case ToastType.error:
        backgroundColor = AppColors.red;
        fontColor = AppColors.black;
        iconData = Icons.error_outline;
        break;
    }

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:backgroundColor,
        textColor: fontColor,
        fontSize: 16.0.sp
    );
  }
}
