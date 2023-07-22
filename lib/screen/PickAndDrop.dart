import 'package:flutter/material.dart';
import '../calender/EC.dart';
import '../calender/GC.dart';
import '../controller/LocationController.dart';
import '../controller/country.dart';
import 'locationScreen.dart';


class PickAndDrop extends StatefulWidget {
  final String title;
  final String pickDropDate;
  final String pickDropCountry;
  final String pickDropLocation;
  final String pickOrDrop;
  final String selectedPickupLocation;
  final String selectedDropLocation;
  final String pickupDate;
  final String dropDate;
  final String pickupCountry;
  final String dropCountry;

  const PickAndDrop({
    super.key,
    required this.title,
    required this.pickDropDate,
    required this.pickDropCountry,
    required this.pickDropLocation,
    required this.pickOrDrop,
    required this.selectedPickupLocation,
    required this.selectedDropLocation,
    required this.dropCountry,
    required this.dropDate,
    required this.pickupCountry,
    required this.pickupDate,
  });
  @override
  State<PickAndDrop> createState() => _PickAndDropState();
}

class _PickAndDropState extends State<PickAndDrop> {
    String selectedDropdownValue = 'Gregorian';


  String selectedCountry = 'Ethiopia 🇪🇹';
   String selectedPickupLocation= '';
  String selectedDropLocation ="";


  late String pickupDate;
  late String dropDate;

  @override
  void initState() {
    super.initState();
    pickupDate = widget.pickupDate;
    dropDate = widget.dropDate;

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:20, left: 30, top: 10, bottom: 10),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children:[
              Text(
                widget.pickDropDate,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),

                  SizedBox(width: 100,),
                  DropdownButton<String>(
                    value: selectedDropdownValue,
                    onChanged: (value) {
                      setState(() {
                        selectedDropdownValue = value!;
                      });
                    },
                    items: <String>['Gregorian', 'Ethiopian'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (selectedDropdownValue == 'Gregorian') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GregorianCalendarP(
                                selectedPickupLocation: widget.selectedPickupLocation == 'Pick up'
                                    ? selectedPickupLocation
                                    : widget.selectedPickupLocation,
                                selectedDropLocation: widget.pickDropLocation == 'Drop'
                                    ? selectedDropLocation
                                    : widget.selectedDropLocation,
                                pickupCountry: widget.pickOrDrop == 'pickup'
                                    ? selectedCountry
                                    : widget.pickupCountry,
                                dropCountry: widget.pickOrDrop == 'drop'
                                    ? selectedCountry
                                    : widget.dropCountry,
                                pick_or_drop_date:widget.pickOrDrop,
                                selectedPickupdate: widget.pickupDate,
                                selectedDropdate: widget.dropDate,
                              ),
                            ),
                          );
                        } else if (selectedDropdownValue == 'Ethiopian') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EthiopianCalender(
                                selectedPickupLocation: widget.selectedPickupLocation == 'Pick up'
                                    ? selectedPickupLocation
                                    : widget.selectedPickupLocation,
                                selectedDropLocation: widget.pickDropLocation == 'Drop'
                                    ? selectedDropLocation
                                    : widget.selectedDropLocation,
                                pickupCountry: widget.pickOrDrop == 'pickup'
                                    ? selectedCountry
                                    : widget.pickupCountry,
                                dropCountry: widget.pickOrDrop == 'drop'
                                    ? selectedCountry
                                    : widget.dropCountry,
                                pick_or_drop_date: widget.pickOrDrop,
                                selectedPickupdate: widget.pickupDate,
                                selectedDropdate: widget.dropDate,
                              ),
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                    Column(
                     children:[
                     Text(
                       ' ${widget.pickOrDrop == 'pickup' ? pickupDate : dropDate}',

                       style: TextStyle(fontSize: 15),
                     ),
                     ]
                   )
                    // Text( pickupDate),
                  //  Text('Drop Date: $dropDate'),


      ]
    )
              ),


              GestureDetector(
                onTap: () async {
                  final selectedCountry = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CountryDialog();
                    },
                  );
                  if (selectedCountry != null) {
                    setState(() {
                      this.selectedCountry = selectedCountry;
                    });
                  }
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.pickDropCountry,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                ),
                              ),
                               SizedBox(width: 10,),
                              Text(
                                selectedCountry,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      alignment: Alignment.centerLeft,
                      child: (() {
                        String country = selectedCountry;
                        String dropValue = '';
                        if (country == 'Ethiopia 🇪🇹') {
                          setState(() {
                            dropValue = widget.pickDropLocation;
                          });
                          return LocationController().locationBox(
                            dropValue,
                                () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LocationScreen(
                                  pick_or_drop_location: widget.pickOrDrop,
                                  selectedPickupLocation: widget.selectedPickupLocation,
                                  selectedDropLocation: widget.selectedDropLocation,
                                  // pick
                                  pickupCountry: widget.pickOrDrop == 'pickup'
                                      ? selectedCountry
                                      : widget.pickupCountry,
                                  pickupDate: widget.pickOrDrop == 'pickup'
                                      ? pickupDate.toString()
                                      : widget.pickupDate,
                                  // drop
                                  dropCountry: widget.pickOrDrop == 'drop'
                                      ? selectedCountry
                                      : widget.dropCountry,
                                  dropDate: widget.pickOrDrop == 'drop'
                                      ? dropDate.toString()
                                      : widget.dropDate,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Text(
                            'No locations to be selected for $country!',
                            style: TextStyle(
                              color: Colors.red, // Set the text color to red
                            ),
                          );
                        }
                      })(),
                    ),
                  ],
                ),
              ),
          ]
    ),

    );


  }
}