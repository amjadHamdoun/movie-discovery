import 'package:easy_localization/easy_localization.dart';
import 'package:fh/core/utils/enums.dart';
import 'package:flutter/material.dart';

extension DateTimeUtils on DateTime {
  String get dayFormat => '$day/$month/$year';

  Duration get subtractFromNow => difference(DateTime.now());

  String get timeFormat => DateFormat('h:mm a').format(this);
}

extension StringUtils on String {
  String get toPascalCase {
    if(isEmpty) {
      return '';
    }
    final List<String> allLetters = split('');
    String ret = '';
    for (int i = 0; i < allLetters.length; i++) {
      if (i == 0) {
        ret += allLetters[0].toUpperCase();
      }else if (allLetters[i] == ' ') {
        ret += ' ${allLetters[i+1].toUpperCase()}';
        if(i!=allLetters.length-1) {
          i++;
        }
      }  else if (allLetters[i] == allLetters[i].toUpperCase()) {
        ret += ' ${allLetters[i]}';
      }else {
        ret += allLetters[i];
      }

    }

    return ret;
  }

  String get capitalized {
    if(isEmpty) {
      return '';
    }
    final String result = toPascalCase.toLowerCase();

    final List<String> letters = result.split('');
    letters[0] = letters[0].toUpperCase();
    return letters.fold('', (final pre, final current) => '$pre$current');
  }


}

extension BuildContextUtils on BuildContext {
  DeviceType get deviceType {
    final double shortestSide = MediaQuery.of(this).size.shortestSide;

    if (shortestSide < 600) {
      return DeviceType.phone;
    } else if (shortestSide >= 600 && shortestSide < 1024) {
      return DeviceType.tablet;
    } else {
      return DeviceType.largerDevice;
    }
  }
}
