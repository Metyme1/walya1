
import 'package:flutter/material.dart';

import 'PickAndDrop.dart';
class MainScreen extends StatefulWidget {
  final String selectedPickupLocation;
  final String selectedDropLocation;
  final String pickupDate;
  final String pickupCountry;
  final String dropDate;
  final String dropCountry;

  const MainScreen({
    super.key,
    required this.selectedPickupLocation,
    required this.selectedDropLocation,
    required this.pickupDate,
    required this.pickupCountry,
    required this.dropDate,
    required this.dropCountry,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isPickupSelected = true;
  bool isDropSelected = true;
  String _selectedPickupLocation = '';
  String _selectedDropLocation = '';

  @override
  void initState() {
    super.initState();
    _selectedPickupLocation = widget.selectedPickupLocation;
    _selectedDropLocation = widget.selectedDropLocation;
    if (_selectedPickupLocation.isNotEmpty) {
      isPickupSelected = true;
    }
    if (_selectedDropLocation.isNotEmpty) {
      isDropSelected = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pickup/Drop',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add your back button logic here
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Add your home button logic here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(right: 30, left: 30, top: 10, bottom: 10),
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isPickupSelected,
                    onChanged: (newValue) {
                      setState(() {
                        isPickupSelected = newValue!;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Pickup',
                    style: TextStyle(
                      color: isPickupSelected ? Colors.teal : Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Checkbox(
                    value: isDropSelected,
                    onChanged: (newValue) {
                      setState(() {
                        isDropSelected = newValue!;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Drop',
                    style: TextStyle(
                      color: isDropSelected ? Colors.teal : Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // pickup and drop information
          Column(
            children: [

              if (isPickupSelected || isDropSelected)
                Text(
                  isPickupSelected ? 'Pickup Information' : 'Drop Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              if (isPickupSelected)
                PickAndDrop(
                  title: 'Pickup Location',
                  pickDropLocation: _selectedPickupLocation.isNotEmpty
                      ? _selectedPickupLocation
                      : 'Pickup Location',
                  pickOrDrop: 'pickup',
                  selectedPickupLocation: widget.selectedPickupLocation,
                  selectedDropLocation: widget.selectedDropLocation,
                  pickupCountry: widget.pickupCountry,
                  pickupDate: widget.pickupDate,
                  dropCountry: widget.dropCountry,
                  dropDate: widget.dropDate,
                  pickDropDate: 'Pickup date:',
                  pickDropCountry: 'Pickup country:',
                ),
            ],
          ),
              Column(
                children: [
                  if (isPickupSelected || isDropSelected)
                    Text(
                      isPickupSelected ? 'Drop Information' : 'pick up Information',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  if (isDropSelected)
                    PickAndDrop(
                      title: 'Drop Location',
                      pickDropLocation: _selectedDropLocation.isNotEmpty
                          ? _selectedDropLocation
                          : 'Drop Location',
                      pickOrDrop: 'Drop',
                      selectedPickupLocation: widget.selectedPickupLocation,
                      selectedDropLocation: widget.selectedDropLocation,
                      pickupCountry: widget.pickupCountry,
                      pickupDate: widget.pickupDate,
                      dropCountry: widget.dropCountry,
                      dropDate: widget.dropDate,
                      pickDropDate: 'Drop date:',
                      pickDropCountry: 'Drop country:',
                    ),

                ],
              ),


        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 20),
        height: 70,
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'Next',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
          ),
        ),
      ),
    );
  }

}