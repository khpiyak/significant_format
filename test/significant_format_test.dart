import 'package:flutter_test/flutter_test.dart';
import 'package:significant_format/significant_format.dart';

void main() {
  test('truncate', () {
    final formatter = SignificantFormat();
    expect(formatter.truncate(12, 4), "12.00");
    expect(formatter.truncate(123, 4), "123.0");
    expect(formatter.truncate(1234, 4), "1234");
    expect(formatter.truncate(12345, 4), "12340");
    expect(formatter.truncate(12345.0, 4), "12340");
    expect(formatter.truncate(12345.0, 4, locale: "en"), "12,340");
    expect(formatter.truncate(12345.0, 4, locale: "in_ID"), "12.340");

    expect(formatter.truncate(0.012, 4), "0.01200");
    expect(formatter.truncate(0.0155, 4), "0.01550");
    expect(formatter.truncate(0.12345, 4), "0.1234");
    expect(formatter.truncate(0.000012345, 4), "0.00001234");
    expect(formatter.truncate(0.000012345, 4, locale: "in_ID"), "0,00001234");
  });

  test('roundUp', () {
    final formatter = SignificantFormat();
    expect(formatter.roundUp(12, 4), "12.00");
    expect(formatter.roundUp(123, 4), "123.0");
    expect(formatter.roundUp(1234, 4), "1234");
    expect(formatter.roundUp(12345, 4), "12350");
    expect(formatter.roundUp(12345, 4, locale: "en"), "12,350");
    expect(formatter.roundUp(12345, 4, locale: "in_ID"), "12.350");

    expect(formatter.roundUp(0.012, 4), "0.01200");
    expect(formatter.roundUp(0.0155, 2), "0.015");
    // double 0.145 == 0.1449999999999999900079927783735911361873149871826171875
    // thus roundup will become 1.14 instead of 1.15
    expect(formatter.roundUp(0.145, 2), "0.14");
    expect(formatter.roundUp(0.1345, 3), "0.135");
    expect(formatter.roundUp(0.01345, 3), "0.0135");
    expect(formatter.roundUp(0.12345, 4), "0.1235");
    expect(formatter.roundUp(0.000012345, 4), "0.00001234");
  });
}
