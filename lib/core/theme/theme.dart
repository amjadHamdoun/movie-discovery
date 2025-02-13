import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';


class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: AppColors.primaryTheme,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryColor ,

    textTheme: textTheme,
    fontFamily: 'SFUI',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: AppColors.primaryTheme,
    primaryColor: AppColors.primaryColor ,
    scaffoldBackgroundColor: AppColors.black,
    textTheme: darkTextTheme,
    fontFamily: 'SFUI',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.deepGrey,
      foregroundColor: Colors.white,
    ),
  );

  static final TextTheme textTheme = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 36.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,

      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 32.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.black,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 28.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 24.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 20.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 12.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.black,
    ),
    labelSmall: TextStyle(
      fontSize: 10.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.black,
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    headlineMedium: TextStyle(
      fontSize: 36.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,

      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 32.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 28.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 24.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 20.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 12.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 10.spMin,
      //height: getIt<LocalizationController>().isRtlLanguage ? 1.3 : null,
      color: AppColors.white,
    ),
  );

}
