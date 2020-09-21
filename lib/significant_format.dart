library significant_format;

import 'dart:math';

import 'package:intl/intl.dart';

class SignificantFormat {
  final String locale;
  final String defaultLocale;

  SignificantFormat({this.locale, this.defaultLocale = "en"});

  roundUp(
    double value,
    int significant, {
    String locale,
    String defaultLocale,
  }) {
    assert(value != null);
    assert(significant != null);

    final String rawValueStr = value.toString();
    final String sfFormatted = value.toStringAsPrecision(significant);
    final double roundupValue = double.parse(sfFormatted);

    final bool overDigi = rawValueStr.contains(".")
        ? rawValueStr.substring(0, rawValueStr.indexOf(".")).length >
            significant
        : rawValueStr.length > significant;

    int decimalPlace = 0;

    if (!overDigi && sfFormatted.contains(".")) {
      final String decimalPart =
          sfFormatted.substring(sfFormatted.indexOf("."), sfFormatted.length);
      decimalPlace = decimalPart.length - 1;
    }

    if (locale == null) {
      return roundupValue.toStringAsFixed(decimalPlace);
    }
    return _thousandSeparatorFormat(roundupValue, decimalPlace, locale,
        defaultLocale: defaultLocale);
  }

  truncate(
    double value,
    int significant, {
    String locale,
    String defaultLocale,
  }) {
    assert(value != null);
    assert(significant != null);

    final String sfFormatted = value.toStringAsPrecision(significant);
    final String rawValueStr = value.toString();

    double truncatedValue;
    int decimalPlace = 0;
    final bool overDigi = rawValueStr.contains(".")
        ? rawValueStr.substring(0, rawValueStr.indexOf(".")).length >
            significant
        : rawValueStr.length > significant;

    if (overDigi) {
      final int remain = (value - double.parse(sfFormatted)).round().abs();
      truncatedValue = remain == 0
          ? value
          : (value / pow(10, remain.toString().length)).truncate() *
              pow(10, remain.toString().length).toDouble();
    } else if (!sfFormatted.contains(".")) {
      truncatedValue = value;
    } else {
      final String decimalPart =
          sfFormatted.substring(sfFormatted.indexOf("."), sfFormatted.length);
      decimalPlace = decimalPart.length - 1;
      truncatedValue =
          (value * pow(10, decimalPlace)).truncate() / pow(10, decimalPlace);
    }

    if (locale == null) {
      return truncatedValue.toStringAsFixed(decimalPlace);
    }
    return _thousandSeparatorFormat(truncatedValue, decimalPlace, locale,
        defaultLocale: defaultLocale);
  }

  _thousandSeparatorFormat(double value, int dp, String locale,
      {String defaultLocale}) {
    try {
      return NumberFormat.currency(
              decimalDigits: dp, locale: locale, symbol: "")
          .format(value);
    } catch (e) {
      return NumberFormat.currency(
              decimalDigits: dp,
              locale: defaultLocale == null ?? this.defaultLocale,
              symbol: "")
          .format(value);
    }
  }
}
