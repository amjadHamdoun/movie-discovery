import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? title;
  final String? error, hint;
  final bool isObscureText, readOnly, isNeedToAutoFill;
  final Widget? suffixIcon, prefixIcon;
  final TextInputType? textInputType;
  final void Function(String)? onSubmit;
  final TextInputFormatter? inputFormatter;

  final TextEditingController? textController;
  final double? height;
  final Color? fieldColor;
  final int maxLines;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  const CustomTextField({
    required this.title,
    required this.textController,
    this.onSubmit,
    super.key,
    this.isObscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.readOnly = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.textInputType,
    this.inputFormatter,
    this.hint,
    this.focusNode,
    this.error,
    this.height,
    this.fieldColor,
    this.isNeedToAutoFill = false,
  }) : assert(!((textController == null) && (!readOnly)));

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        focusNode: focusNode,
        onChanged:onChanged ,
        textInputAction: TextInputAction.done,
        enabled: !readOnly,
        controller: textController,
        obscureText: isObscureText,
        keyboardType: textInputType,
        maxLines: maxLines,
        maxLength: maxLines > 2 ? 100 : null,
        autofillHints: isNeedToAutoFill ? [AutofillHints.oneTimeCode] : null,

        cursorColor: Theme.of(context).primaryColor,
        inputFormatters: [
          if (inputFormatter != null) inputFormatter!,
        ],
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          errorText: error,
          suffixIcon: suffixIcon != null
              ? Center(
                  child: suffixIcon!,
                )
              : Container(),
          fillColor: fieldColor ?? AppColors.black,
          filled: true,
          prefixIcon: prefixIcon,
          alignLabelWithHint: true,
          isDense: true,
          border:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          errorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColors.red),
          ),
          focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColors.red),
          ),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodySmall!
              .copyWith(color: AppColors.grey),
          prefixIconConstraints: BoxConstraints(
            minWidth: 48.r,
            maxWidth: 48.r,
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: 48.r,
            maxWidth: 48.r,
          ),
          label: title != null
              ? RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                      text: title!,
                      style: Theme.of(context).textTheme.bodyMedium!
                          .copyWith(color: AppColors.grey),
                      ),
                )
              : null,
        ),
      ),
    );
  }
}
