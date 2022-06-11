import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class Ui {
  static final ThemeData light = ThemeData.light().copyWith(
    appBarTheme: commonTheme.appBarTheme,
    checkboxTheme: commonTheme.checkboxTheme,
    scaffoldBackgroundColor: commonTheme.scaffoldBackgroundColor,
    primaryColor: commonTheme.primaryColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xFF273fdb),
      secondary: const Color(0xFFff4d62),
      error: const Color.fromARGB(255, 241, 42, 58),
    ),
    textTheme: commonTheme.textTheme,
    shadowColor: commonTheme.shadowColor,
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      dayPeriodShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      hourMinuteShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      dialBackgroundColor: Constants.lightBlue,
    ),
  );

  static final ThemeData dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF16171F),
    primaryColor: const Color(0xFF1a2fb3),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: const Color(0xFF1a2fb3),
      secondary: const Color(0xFFff4d62),
      error: const Color.fromARGB(255, 241, 42, 58),
    ),
    shadowColor: commonTheme.shadowColor,
    checkboxTheme: commonTheme.checkboxTheme,
    timePickerTheme: TimePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      dayPeriodShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      hourMinuteShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      dialBackgroundColor: Constants.lightBlue,
    ),
    appBarTheme: commonTheme.appBarTheme.copyWith(
      backgroundColor: const Color(0xFF21212F),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: commonTheme.textTheme,
  );
  static final ThemeData commonTheme = ThemeData(
    fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Almarai',
    primaryColor: const Color(0xFF273fdb),
    scaffoldBackgroundColor: Colors.white,
    // fontFamily: Get.locale == const Locale('en') ? 'Poppin' : 'Noor',
    shadowColor: const Color.fromRGBO(39, 63, 219, 0.09),
    appBarTheme: AppBarTheme(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      shadowColor: const Color.fromRGBO(39, 63, 219, 0.09),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(const Color(0xFFF3F4FD)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: const BorderSide(width: 9, color: Color(0xFFF3F4FD)),
    ),
  );

  static void successGetBar({@required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          style: Get.textTheme.caption.merge(
            const TextStyle(color: Colors.white),
          ),
        ),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        backgroundColor: Constants.successColor,
        icon: const Icon(
          Icons.check_circle_outline,
          size: 32,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        borderRadius: 15,
        dismissDirection: DismissDirection.horizontal,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void errorGetBar({@required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Text(
          message,
          style: Get.textTheme.caption.merge(
            const TextStyle(color: Colors.white),
          ),
        ),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        backgroundColor: Get.theme.colorScheme.secondary,
        icon: const Icon(
          Icons.remove_circle_outline,
          size: 32,
          color: Colors.white,
        ),
        overlayBlur: 2.5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        borderRadius: 15,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
