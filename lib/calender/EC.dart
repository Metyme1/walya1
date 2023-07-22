import 'dart:math';

import 'package:flutter/material.dart';
import 'package:abushakir/abushakir.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import '../screen/MainScreen.dart';
import 'Ethiopian.dart';
import 'Gregorian.dart';


class EthiopianCalender extends StatefulWidget {
  final String pick_or_drop_date;
  final String selectedPickupLocation;
  final String selectedDropLocation;
  final String selectedPickupdate;
  final String selectedDropdate;
  final String pickupCountry;

  final String dropCountry;

  EthiopianCalender({
    required this.pick_or_drop_date,
    required this.selectedPickupLocation,
    required this.selectedDropLocation,
    required this.selectedPickupdate,
    required this.selectedDropdate,
    required this.pickupCountry,
    required this.dropCountry,
  });


  @override
  State<EthiopianCalender> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<EthiopianCalender> {
  ETC current = ETC.today();
  ETC now = ETC.today();
  BahireHasab bh = BahireHasab();
 EtDatetime selectedDate = EtDatetime.now();
  String selectDate='';
  String _Gregoriandate = '';

  late EtDatetime dateForPickup = EtDatetime.now();
  late EtDatetime dateForDrop = EtDatetime.now();


  @override
  void initState() {
    super.initState();
    bh = BahireHasab(year: current.year);
  }

  @override
  Widget build(BuildContext context) {
    ETC _selectedDay= ETC.today();
  //  var size = MediaQuery.of(context).size;
    var days = current.monthDays().toList();
    var startJump = days[0].last;

    var today = EtDatetime(year: now.year, day: now.day, month: now.month);
    var startIndex = days.indexWhere((date) => fromArray(date) == today);
    days = days.sublist(startIndex);

    final Ec = EthiopianCalendar(year: selectedDate.year, month: selectedDate.month, day: selectedDate.day);
    final Gc = Ec.toGC();
    final monthName = Ec.month_name;
    _Gregoriandate = '${Gc!.day!} ${Gc?.month_name} ${Gc?.year!}';

    String selectedDateString = '';




    final List<String> weekDays = [

      "ሰኞ",
      "ማግሰኞ",
      "ረቡዕ",
      "ሐሙስ",
      "አርብ",
      "ቅዳሜ",
      "እሁድ",
    ];

    final List<String> months = [
      "መስከረም",
      "ጥቅምት",
      "ኅዳር",
      "ታኅሳስ",
      "ጥር",
      "የካቲት",
      "መጋቢት",
      "ሚያዝያ",
      "ግንቦት",
      "ሰኔ",
      "ኃምሌ",
      "ነሐሴ",
      "ጷጉሜን"
    ];
    return Scaffold(

      appBar: AppBar(
        foregroundColor: Colors.white,

        title: const Text('Ethiopian Calendar'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          // padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              current = current.prevMonth;
                            });
                          },
                          icon: const Icon(Icons.chevron_left),
                          iconSize: 30,
                            color: Colors.black54
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = now;
                            });
                          },
                          child: Text(
                            "${current.monthName} ${current.year}",
                            style: const TextStyle(
                              fontSize: 18,
                                color: Colors.black54
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              current = current.nextMonth;
                            });
                          },
                          icon: const Icon(Icons.chevron_right),
                          iconSize: 30,
                            color: Colors.black54
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: GridView.count(
                        crossAxisCount: 7,
                        children: weekDays
                            .map(
                              (e) => Center(
                            child: Text(
                              '$e',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),

                    SizedBox(
                      height: 7 * 40,
                      child: GridView.count(
                        crossAxisCount: 7,
                        children: [
                          ...List.filled(startJump, 0)
                              .map((e) => const Center(child: Text('')))
                              .toList(),
                          ...days.map((e) {var date = fromArray(e);
                            var isBeforeToday = date.isBefore(today) || date.difference(today).inDays > 15;
                            var isToday = today.compareTo(date) == 0;
                            return GestureDetector(
                              onTap: isBeforeToday
                                  ? null
                                  : () {
                                setState(() {
                                  selectedDate = date;

                                });
                              },
                              child: Material(
                                shape: CircleBorder(),
                                color: isToday ? Colors.teal: Colors.transparent,
                                child: Container(
                                  decoration: isToday
                                      ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.teal,
                                      width: 2,
                                    ),
                                  )
                                      : null,
                                  child: Center(
                                    child: Text(
                                      '${e[2]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: isToday
                                            ? Colors.white
                                            : isBeforeToday
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Selected Date: ${selectedDate.day} ${monthName} ${selectedDate.year} ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Selected Date:  $_Gregoriandate',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                          ),
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(

                          onPressed: () {
                            String _requestedField = widget.pick_or_drop_date;
                            if (_requestedField == 'pickup') {
                              setState(() {
                                final Ec = EthiopianCalendar(year: selectedDate.year, month: selectedDate.month, day: selectedDate.day);
                                final monthName = Ec.month_name;
                                final Gc = Ec.toGC();
                                _Gregoriandate = '${Gc!.day!} ${Gc?.month_name} ${Gc?.year!}';
                                selectedDateString = '${selectedDate.day} ${monthName} ${selectedDate.year} , $_Gregoriandate';
                                dateForPickup = selectedDate;
                              });
                            } else {
                              setState(() {
                                final Ec = EthiopianCalendar(year: selectedDate.year, month: selectedDate.month, day: selectedDate.day);
                                final monthName = Ec.month_name;
                                final Gc = Ec.toGC();
                                _Gregoriandate = '${Gc!.day!} ${Gc?.month_name} ${Gc?.year!}';
                                selectedDateString = '${selectedDate.day} ${monthName} ${selectedDate.year} $_Gregoriandate';
                                dateForDrop = selectedDate;
                              });
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(
                                  selectedPickupLocation: 'select pickup location',
                                  selectedDropLocation: "Select Drop location",
                                  pickupDate: selectedDateString ,
                                  pickupCountry: widget.pickupCountry,
                                  dropDate: selectedDateString ,
                                  dropCountry: widget.dropCountry,
                                ),
                              ),
                            );

                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                          ),
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  ],

                ),
              ),
            ],
          ),

        ),
      ),
    );
  }

  EtDatetime fromArray(List<dynamic> date) {
    return EtDatetime(year: date[0], month: date[1], day: date[2]);
  }
}
