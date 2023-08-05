import 'package:flutter/material.dart';
import '../../widgets/colors.dart';
import 'icon_creation.dart';

// bottom sheet menu
Widget bottomSheet(BuildContext context) {
  return SizedBox(
    height: 278,
    width: MediaQuery.of(context).size.width,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: appBarColor,
      margin: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //iconCreation widget
              iconCreation(Icons.insert_drive_file, Colors.indigo, 'Document'),
              iconCreation(Icons.camera_alt, Colors.pink, 'Camera'),
              iconCreation(Icons.insert_photo, Colors.purple, 'Gallery'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //iconCreation widget
              iconCreation(Icons.headset, Colors.orange, 'Audio'),
              iconCreation(Icons.location_pin, Colors.teal, 'Location'),
              iconCreation(Icons.person, Colors.blue, 'Contact'),
            ],
          )
        ],
      ),
    ),
  );
}
