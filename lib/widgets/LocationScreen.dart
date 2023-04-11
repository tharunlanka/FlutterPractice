import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationState();
}

class _LocationState extends State<LocationScreen> {
  final String _previewImageUrl="https://cdn.pixabay.com/photo/2016/03/22/04/23/map-1272165__340.png";

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
      Scaffold(
          body:Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? const Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text(
                "Current  Location",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Select on Map',
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ],
    ),
    )
    );
  }
}
