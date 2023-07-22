
import 'package:flutter/material.dart';

class CountryDialog extends StatefulWidget {
  const CountryDialog({Key? key}) : super(key: key);

  @override
  _CountryDialogState createState() => _CountryDialogState();
}

class _CountryDialogState extends State<CountryDialog> {
  String selectedCountry = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a country'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: const Text('Ethiopia 🇪🇹'),
              onTap: () {
                setState(() {
                  selectedCountry = 'Ethiopia 🇪🇹';
                });
                Navigator.of(context).pop(selectedCountry);
              },
            ),
            ListTile(
              title: const Text('Eritrea 🇪🇷 '),
              onTap: () {
                setState(() {
                  selectedCountry = 'Eritrea 🇪🇷';
                });
                Navigator.of(context).pop(selectedCountry);
              },
            ),
            ListTile(
              title: const Text('Djibouti 🇩🇯'),
              onTap: () {
                setState(() {
                  selectedCountry = 'Djibouti 🇩🇯';
                });
                Navigator.of(context).pop(selectedCountry);
              },
            ),
            ListTile(
              title: const Text('Kenya 🇰🇪'),
              onTap: () {
                setState(() {
                  selectedCountry = 'Kenya 🇰🇪';
                });
                Navigator.of(context).pop(selectedCountry);
              },
            ),
            ListTile(
              title: const Text('Sudan 🇸🇩'),
              onTap: () {
                setState(() {
                  selectedCountry = 'Sudan 🇸🇩';
                });
                Navigator.of(context).pop(selectedCountry);
              },
            ),
            ListTile(
              title: const Text('South Sudan 🇸🇸'),
              onTap: () {
                setState(() {
                  selectedCountry = 'South Sudan 🇸🇸';
                });
                Navigator.of(context).pop(selectedCountry);
              },
            ),
            ListTile(
              title: const Text('Somalia 🇸🇴'),
              onTap: () {
                setState(() {
                  selectedCountry = 'Somalia 🇸🇴';
                });
                Navigator.of(context).pop(selectedCountry);
              },
            ),
          ],
        ),
      ),
    );
  }
}