
import 'package:walya1/calender/util.dart';

import 'Gregorian.dart';
import 'bahirehaseab.dart';

class EthiopianCalendar {
  int? year;
  int? month;
  int? day;
  String? holiday_name;
  bool isHoliday = false;
  String? month_name;
  String? day_name;

  EthiopianCalendar({this.year, this.month, this.day}) {
    this.month_name = months[this.month! - 1];
    this.holiday_name =
        getHoliday(months[this.month! - 1], this.day, this.year);
    this.isHoliday = holiday_name != "" ? true : false;
  }

  EthiopianCalendar.now() {
    var fixed = fixedFromUnix(DateTime.now().millisecondsSinceEpoch);
    this.year = ((4 * (fixed - ethiopicEpoch) + 1463) ~/ 1461);
    this.month = (((fixed - fixedFromEthiopic(this.year!, 1, 1)) ~/ 30) + 1);
    this.day = fixed + 1 - fixedFromEthiopic(this.year!, this.month!, 1);
    this.month_name = months[(this.month! - 1) % 13];
    this.holiday_name =
        getHoliday(months[this.month! - 1], this.day, this.year);
    this.isHoliday = holiday_name != "" ? true : false;

    var gc = this.toGC();
    this.day_name = dayss[getDayName(gc.month, gc.day, gc.year)];
  }

  GregorianCalendar toGC() {
    return new GregorianCalendar(
        year: DateTime.fromMillisecondsSinceEpoch(
            dateToEpoch(this.year!, this.month!, this.day!))
            .year,
        month: DateTime.fromMillisecondsSinceEpoch(
            dateToEpoch(this.year!, this.month!, this.day!))
            .month,
        day: DateTime.fromMillisecondsSinceEpoch(
            dateToEpoch(this.year!, this.month!, this.day!))
            .day);
  }

  EthiopianCalendar nextMonth() {
    var isLastMonth = this.month == 13 || (this.month == 12 && this.day! > 6);
    return new EthiopianCalendar(
        year: isLastMonth ? this.year! + 1 : this.year,
        month: isLastMonth ? 1 : this.month! + 1,
        day: this.day);
  }

  EthiopianCalendar previousMonth() {
    var isFirstMonth = this.month == 1;
    return new EthiopianCalendar(
        year: isFirstMonth ? this.year! - 1 : this.year,
        month: isFirstMonth ? (this.day! > 6 ? 12 : 13) : this.month! - 1,
        day: this.day);
  }

  EthiopianCalendar nextYear() {
    return EthiopianCalendar(
        year: this.year! + 1, month: this.month, day: this.day);
  }

  // thisYear() {
  //   // return EthiopianCalendar(
  //   //     year: this.year!, month: this.month, day: this.day);
  //   String current_day = '$this.year : $this.month : $this.day';
  //   return current_day;
  // }

  EthiopianCalendar currentDay() {
    return EthiopianCalendar(
        year: this.year!, month: this.month, day: this.day);
  }

  EthiopianCalendar previousYear() {
    return EthiopianCalendar(
        year: this.year! - 1, month: this.month, day: this.day);
  }

  int daysInMonth() {
    if (this.month == 13) {
      // In a leap year, the 13th month has 6 days
      return isLeapYear(this.year!) ? 6 : 5;
    } else {
      // All other months have 30 days
      return 30;
    }
  }

  bool isLeapYear(int year) {
    // A year is a leap year if it is divisible by 4 and not divisible by 100,
    // or if it is divisible by 400
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  // int firstDayOfWeek() {
  //   var epochDay = fixedFromEthiopic(this.year!, this.month!, 1) - 1;
  //   // The Ethiopic calendar has a 7-day week
  //   return (epochDay + 3) % 7;
  // }
  int firstDayOfWeek() {
    // Calculate the epoch day of the first day of the current month
    int epochDay = fixedFromEthiopic(year!, month!, 1) - 1;

    // Calculate the number of leap days in the current year up to the current month
    int leapDays = 0;
    for (int i = 1; i < month!; i++) {
      if (i == 13 && isLeapYear(year!)) {
        leapDays += 1;
      }
      leapDays += 1;
    }

    // Calculate the first day of the week by adding the epoch day and leap days
    // to an offset of 3 (corresponding to September 1st, 8 CE, in the Julian calendar)
    int firstDayOfWeek = (epochDay + leapDays + 3) % 7;

    return firstDayOfWeek;
  }
}