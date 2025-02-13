import 'package:fh/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/debouncer.dart';
import 'custom_text_field.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController? textController;
  final void Function(String) onSearchStringChanged;
  final Color? fieldColor;
  final String? initialString,hint;
  final FocusNode? focusNode;
  final bool isOfflineSearch;

  const SearchTextField(
      {required this.fieldColor,
      required this.onSearchStringChanged,
      this.textController,
      this.initialString,
      this.hint,
      super.key,
      this.focusNode,
        this.isOfflineSearch=false
      });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late Debouncer debouncer = Debouncer(duration: Duration( milliseconds:widget.isOfflineSearch?0: 850));
  late TextEditingController textController;
  @override
  void initState() {
    textController = widget.textController ?? TextEditingController(text: widget.initialString);
    super.initState();
  }
  @override
  void didUpdateWidget(covariant final SearchTextField oldWidget) {
    textController=TextEditingController(text: widget.initialString);
    super.didUpdateWidget(oldWidget);
  }

  void onChangeString() {

    if (textController.text.trim().isEmpty || textController.text.trim().length >= (widget.isOfflineSearch?0:1)) {
      debouncer.run(() => widget.onSearchStringChanged(textController.text));
    }
  }

  @override
  Widget build(final BuildContext context) {
    return CustomTextField(
      fieldColor: widget.fieldColor,
      focusNode: widget.focusNode,
      onChanged: (final _)=>onChangeString(),
      title: null,
      height: 32.h,
      hint: widget.hint??'Search',
      textController: textController,

      prefixIcon: Icon(
        Icons.search,
        size: 20.r,
        color: AppColors.grey,
      ),
      suffixIcon: IconButton(
        icon: Icon(
          Icons.close,
          size: 20.r,
          color: AppColors.grey,
        ),
        onPressed: (){
          if(textController.text.isNotEmpty){
            onChangeString();
            textController.clear();
          }

        },
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    widget.focusNode?.dispose();
    super.dispose();
  }
}
