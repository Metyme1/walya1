import 'package:flutter/material.dart';

class LocationController {
  Widget locationBox(String location, void Function() onTapLocation) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTapLocation,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 10),
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.location_on,
                      size: 25.0,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      location,
                      style: const TextStyle(
                        color: Color(0xff1c1c1c),
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}