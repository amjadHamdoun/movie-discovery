import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadSectionWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback voidCallback;
  const HeadSectionWidget({super.key,required this.title,
    required this.buttonText,required this.voidCallback });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w700
          )),
          TextButton(onPressed: voidCallback, child: Text(buttonText,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w700
          ))),
        ],
      ),
    );
  }
}
