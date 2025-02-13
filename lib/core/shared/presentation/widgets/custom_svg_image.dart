import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImage extends StatelessWidget {
  final String path;
  final double size;
  final Color? color;
  const CustomSvgImage(
      {required this.path, super.key, this.size = 24, this.color});

  @override
  Widget build(final BuildContext context) {
    return SvgPicture.asset(
      path,
      height: size.r,
      width: size.r,
      color: color,
    );
  }
}
