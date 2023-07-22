import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


import '../screen/MainScreen.dart';
import 'Gregorian.dart';

class GregorianCalendarP extends StatefulWidget {
  final String pick_or_drop_date;
  final String selectedPickupLocation;
  final String selectedDropLocation;
  final String selectedPickupdate;
  final String selectedDropdate;
  final String pickupCountry;

  final String dropCountry;

  GregorianCalendarP({
    required this.pick_or_drop_date,
    required this.selectedPickupLocation,
    required this.selectedDropLocation,
    required this.selectedPickupdate,
    required this.selectedDropdate,
    required this.pickupCountry,
    required this.dropCountry,
  });
  @override
  _GregorianCalendarPState createState() => _GregorianCalendarPState();
}



class _GregorianCalendarPState extends State<GregorianCalendarP> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String _ethiopianDate = '';
  DateTime? _selectedDate;

  @override
  String? dateForPickup;
  String? dateForDrop;
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime startDate = now.subtract(Duration(days: 1));
    final DateTime endDate = now.add(Duration(days: 15));

    final availableCalendarFormats = CalendarBuilders(
      // Custom builder function to disable dates before the current date and after 16 days from the current date
      disabledBuilder: (context, date, _) {
        if (date.isBefore(startDate) || date.isAfter(endDate)) {
          return Container(
            decoration: BoxDecoration(

            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          );
        } else {
          return null;
        }
      },
    );
    final gc = GregorianCalendar(year: _selectedDay.year, month: _selectedDay.month, day: _selectedDay.day);
    final ec = gc.toEc();
    _ethiopianDate = '${ec!.day! + 1} ${ec?.month_name} ${ec?.year!}';

    String selectedDate;
    if (_ethiopianDate != null && _selectedDate != null) {
      selectedDate = '$_ethiopianDate, ${DateFormat('MMMM d, yyyy').format(_selectedDate!)}';
    } else {
      selectedDate = 'Today, ${DateFormat('MMMM d, yyyy').format(DateTime.now())}';
    }
    bool isEthiopianCalendar = false;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.teal,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Gregorian Calendar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      body: Column(

        children: [

          TableCalendar(
            firstDay: startDate,
            focusedDay: _focusedDay,
            lastDay: endDate,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedDate = selectedDay;
              });

            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: availableCalendarFormats,
          ),
          SizedBox(height: 20),

          Text(
            'Selected day: ${DateFormat('MMMM d, yyyy').format(_selectedDay)}',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            'Ethiopian date: $_ethiopianDate',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 40,),
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
                      dateForPickup = selectedDate;
                    });
                  } else {
                    setState(() {
                      dateForDrop = selectedDate;
                    });
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(
                        selectedPickupLocation: 'select pickup location',
                        selectedDropLocation: "Select Drop location",
                        pickupDate: dateForPickup ?? widget.selectedPickupdate,
                        pickupCountry: widget.pickupCountry,
                        dropDate: dateForDrop ?? widget.selectedDropdate,
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
    );
  }
}