import 'package:fh/core/utils/assets.dart';
import 'package:fh/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';

class AppErrorWidget extends StatelessWidget {
  final ErrorType error;
  final VoidCallback? onPressed;
  final String image;
  final Color? iconColor;

  const AppErrorWidget({
    super.key,
    required this.error,
    this.onPressed,
    this.iconColor,
  }) : image = error==ErrorType.noDataFound? Assets.noData:Assets.error;


  @override
  Widget build(BuildContext context) {
    return FadeIn( // Smooth animation
      duration: const Duration(milliseconds: 500),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            spacing: 16.h,
            children: [

              Image.asset(image, width: 170.r, height: 170.w), // Increased size

              Row(
                children: [
                  Expanded(
                    child: Text(
                      error.message,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(

                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              if (onPressed != null)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor, // Primary theme color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
                  ),
                  onPressed: onPressed,
                  icon: Icon(Icons.refresh, color: Colors.white, size: 22.sp),
                  label: Text(
                    "Retry",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
