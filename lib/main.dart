import 'package:flutter/material.dart';


import 'screen/MainScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waliya',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MainScreen(
        selectedPickupLocation: '',
        selectedDropLocation: '',
        pickupCountry: '',
        pickupDate: '',
        dropDate: '',
        dropCountry: '',
      ),
    );
  }
}