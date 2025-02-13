import 'dart:math';

import 'package:flutter/services.dart';

class MaskedInputFormatter extends TextInputFormatter {
  final String mask;

  final String _anyCharMask = '#';
  final String _onlyDigitMask = '0';
  final RegExp? allowedCharMatcher;
  final List<int> _separatorIndices = <int>[];
  final List<String> _separatorChars = <String>[];
  String _maskedValue = '';

  /// [mask] is a string that must contain # (hash) and 0 (zero)
  /// as maskable characters. # means any possible character,
  /// 0 means only digits. So if you want to match e.g. a
  /// string like this GGG-FB-897-R5 you need
  /// a mask like this ###-##-000-#0
  /// a mask like ###-### will also match 123-034 but a mask like
  /// 000-000 will only match digits and won't allow a string like Gtt-RBB
  ///
  /// will match literally any character unless
  /// you supply an [allowedCharMatcher] parameter with a RegExp
  /// to constrain its values. e.g. RegExp(r'[a-z]+') will make #
  /// match only lowercase latin characters and everything else will be
  /// ignored
  MaskedInputFormatter(
    this.mask, {
    this.allowedCharMatcher,
  });

  bool get isFilled => _maskedValue.length == mask.length;

  String get unmaskedValue {
    _prepareMask();
    final stringBuffer = StringBuffer();
    for (var i = 0; i < _maskedValue.length; i++) {
      final char = _maskedValue[i];
      if (!_separatorChars.contains(char)) {
        stringBuffer.write(char);
      }
    }
    return stringBuffer.toString();
  }

  @override
  TextEditingValue formatEditUpdate(
    final TextEditingValue oldValue,
    final TextEditingValue newValue,
  ) {
    final FormattedValue formattedValue = applyMask(
      newValue.text,
    );
    var selectionOffset =
        newValue.selection.end + formattedValue.selectionOffset;
    _maskedValue = formattedValue.toString();
    if (selectionOffset > _maskedValue.length) {
      selectionOffset = _maskedValue.length;
    }

    return TextEditingValue(
      text: _maskedValue,
      selection: TextSelection.collapsed(
        offset: selectionOffset,
      ),
    );
  }

  bool _isMatchingRestrictor(final String character) {
    if (allowedCharMatcher == null) {
      return true;
    }
    return allowedCharMatcher!.stringMatch(character) != null;
  }

  void _prepareMask() {
    if (_separatorIndices.isEmpty) {
      for (var i = 0; i < mask.length; i++) {
        if (mask[i] != _anyCharMask && mask[i] != _onlyDigitMask) {
          _separatorIndices.add(i);
          _separatorChars.add(mask[i]);
        }
      }
    }
  }

  int _countSeparators(final String text) {
    _prepareMask();
    var numSeparators = 0;
    for (var i = 0; i < text.length; i++) {
      if (_separatorChars.contains(text[i])) {
        numSeparators++;
      }
    }
    return numSeparators;
  }

  String _removeSeparators(final String text) {
    final stringBuffer = StringBuffer();
    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      if (!_separatorChars.contains(char)) {
        stringBuffer.write(char);
      }
    }
    return stringBuffer.toString();
  }

  FormattedValue applyMask(final String text) {
    _prepareMask();
    final int numSeparatorsBefore = _countSeparators(text);
    final String clearedValueAfter = _removeSeparators(text);
    final isErasing = _maskedValue.length > text.length;
    final FormattedValue formattedValue = FormattedValue();
    final StringBuffer stringBuffer = StringBuffer();
    var index = 0;
    final maxLength = min(
      clearedValueAfter.length,
      mask.length - _separatorChars.length,
    );

    for (var i = 0; i < maxLength; i++) {
      final curChar = clearedValueAfter[i];
      if (!_isMatchingRestrictor(curChar)) {
        continue;
      }
      if (_separatorIndices.contains(index)) {
        stringBuffer.write(mask[index]);
        index++;
      }
      stringBuffer.write(curChar);
      index++;
    }
    formattedValue._isErasing = isErasing;
    formattedValue._formattedValue = stringBuffer.toString();
    formattedValue._numSeparatorsAfter = _countSeparators(
      formattedValue._formattedValue,
    );
    formattedValue._numSeparatorsBefore = numSeparatorsBefore;
    return formattedValue;
  }
}

class FormattedValue {
  String _formattedValue = '';
  int _numSeparatorsBefore = 0;
  int _numSeparatorsAfter = 0;
  bool _isErasing = false;

  int get selectionOffset {
    final offset = (_numSeparatorsAfter - _numSeparatorsBefore).abs();
    return _isErasing ? 0 : offset;
  }

  @override
  String toString() {
    return _formattedValue;
  }
}
