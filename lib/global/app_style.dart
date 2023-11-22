import 'package:flutter/material.dart';

abstract class AppStyle {

  static const double defaultPaddingVal = 20;
  static const defaultPadding = EdgeInsets.symmetric(
      horizontal: defaultPaddingVal);
  static const defaultPaddingAll = EdgeInsets.all(defaultPaddingVal);

  static const double defaultRadiusVal = 15;
  static const defaultRadius = Radius.circular(defaultRadiusVal);

  static const double controlDistanceVal = 15;
  static const horizontalDefaultDistance = SizedBox(width: controlDistanceVal);
  static const verticalDefaultDistance = SizedBox(height: controlDistanceVal);

  static const double wrapSpacing = 12;


  static const titleLargeTextStyle = TextStyle(
      fontSize: AppFontSize.big,
      fontWeight: FontWeight.w500,
      color: AppColor.secondary,
      letterSpacing: 1.3
  );

  static const midWhite30 = TextStyle(
      fontSize: AppFontSize.medium,
      fontWeight: FontWeight.w500,
      color: AppColor.white30,
      letterSpacing: 1.2
  );

  static const mediumDark = TextStyle(
      fontSize: AppFontSize.medium,
      fontWeight: FontWeight.w500,
      color: AppColor.black70,
      letterSpacing: 1
  );

  static const labelMediumTextStyle = TextStyle(
      fontSize: AppFontSize.medium,
      fontWeight: FontWeight.w500,
      color: AppColor.white80,
      letterSpacing: 1.1
  );

  static const primaryMedium = TextStyle(
      fontSize: AppFontSize.medium,
      fontWeight: FontWeight.w500,
      color: AppColor.primary,
      letterSpacing: 1.1
  );

  static const secondaryMedium = TextStyle(
      fontSize: AppFontSize.medium,
      fontWeight: FontWeight.w500,
      color: AppColor.secondary,
      letterSpacing: 1.1
  );

  static const textInput = TextStyle(
      fontSize: AppFontSize.medium,
      fontWeight: FontWeight.w500,
      color: AppColor.white,
      letterSpacing: 1.1
  );

  static const listTileTitle = TextStyle(
      fontSize: AppFontSize.medium,
      fontWeight: FontWeight.w500,
      color: AppColor.secondary,
      letterSpacing: 1
  );

  static const listTileSubtitle = TextStyle(
      fontSize: AppFontSize.small,
      fontWeight: FontWeight.w300,
      color: AppColor.white,
      letterSpacing: 1
  );

  static const smallWhite80 = TextStyle(
      fontSize: AppFontSize.small,
      fontWeight: FontWeight.w300,
      color: AppColor.white80,
      letterSpacing: 1
  );

  static const smallPrimary = TextStyle(
      fontSize: AppFontSize.small,
      fontWeight: FontWeight.w300,
      color: AppColor.primary,
      letterSpacing: 1
  );
}





abstract class AppFont {

  static const String robotoMono = 'RobotoMono';
}

abstract class AppFontSize {
  static const double small = 12;
  static const double medium = 16;
  static const double big = 24;
  static const double huge = 32;
}



abstract class AppColor {

  static const Color white = Color(0xFFFFFFFF);
  static const Color white80 = Color(0xCCFFFFFF);
  static const Color white30 = Colors.white30;

  static const Color black70 = Color(0xB3000000);

  static const Color primaryDark = Colors.deepPurple;
  static const Color primary = Colors.deepPurple;
  static const Color primaryLight = Colors.deepPurple;

  static const Color secondary = Color(0xFFF9AA33);
  static const Color secondaryInactive = Color(0x57C58425);
  static const Color secondaryContrast = primaryDark;

  static const Color blue = Color(0xFF3366FF);
  static const Color blueInactive = Color(0x812749B4);
  static const Color blueContrast = black70;

  static const Color red = Color(0xFFFF5733);
  static const Color redInactive = Color(0x74AD3922);
  static const Color redContrast = primaryDark;

  static List<Color> mapFlutterIconColors = [
    const Color(0xFF4687C1),
    const Color(0xFFC93D48),
    const Color(0xFFA2A3A5),
    const Color(0xFFC761AD),
    const Color(0xFFF2A400),
    const Color(0xFF4FA03B),
    const Color(0xFF756CB7),
    const Color(0xFF3B4043),
  ];

  static Color mapFlutterIconDefaultColor = mapFlutterIconColors.first;

}