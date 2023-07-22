import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


import 'MainScreen.dart';

class LocationScreen extends StatefulWidget {
  final String pick_or_drop_location;
  final String selectedPickupLocation;
  final String selectedDropLocation;
  final String pickupDate;
  final String pickupCountry;
  final String dropDate;
  final String dropCountry;

  LocationScreen({
    required this.pick_or_drop_location,
    required this.selectedPickupLocation,
    required this.selectedDropLocation,
    required this.pickupDate,
    required this.pickupCountry,
    required this.dropDate,
    required this.dropCountry,
  });
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLocations();
  }

  void _initLocations() async {
    List<String> locations = await location('');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('locations', locations);
  }

  Future<List<String>> location(String query) async {
    String url = "http://amircreations.com/walya/get_all_places.php";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['response'];
        Set<String> citySuggestions = Set<String>();
        for (var location in data) {
          String cityName = location['city'];
          String zone = location['zone'];
          String title = location['title'];

          // Perform null checks before creating the suggestion
          if (cityName != null &&
              cityName.toLowerCase().contains(query.toLowerCase())) {
            String suggestion = '$cityName | $zone | $title';
            citySuggestions.add(suggestion);
          }
        }

        if (query.isEmpty) {
          citySuggestions = data.map<String>((location) {
            String cityName = location['city'];
            String zone = location['zone'];
            String title = location['title'];
            return '$cityName | $zone | $title';
          }).toSet();
        }
        return citySuggestions.toList(); // Convert Set to List for suggestions
      } else {
        throw Exception('Failed to load location suggestions');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }

  String? searchResultForPickup;
  String? searchResultForDrop;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select ${widget.pick_or_drop_location == 'pickup' ? 'Pickup' : 'Drop'} Location'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: SingleChildScrollView(
          child: TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'City | zone | title',
                border: OutlineInputBorder(),
              ),
            ),
            suggestionsCallback: (pattern) async {
              return await location(pattern);
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  String _requestedField = widget.pick_or_drop_location;

                  if (_requestedField == 'pickup') {
                    setState(() {
                      searchResultForPickup = suggestion;
                       searchResultForDrop = widget.selectedDropLocation;
                    });
                  } else {
                    setState(() {
                      searchResultForDrop = suggestion;
                      searchResultForPickup = widget.selectedPickupLocation;
                    });
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // pass necessary parameters to ConfirmScreen()
                      builder: (context) =>
                          MainScreen(
                        selectedPickupLocation: searchResultForPickup?? widget.selectedPickupLocation,
                        selectedDropLocation: searchResultForDrop?? widget.selectedPickupLocation,
                        pickupDate: widget.pickupDate,
                        pickupCountry: widget.pickupCountry,
                        dropDate: widget.dropDate,
                        dropCountry: widget.dropCountry,
                      ),
                    ),
                  );
                },
              );
            }, onSuggestionSelected: (String suggestion) {  },
            // onSuggestionSelected:
            //     (suggestion) {}, // Added this line to fix the error
          ),
        ),
      ),
    );

  }
}