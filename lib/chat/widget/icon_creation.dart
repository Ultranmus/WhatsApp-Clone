import 'package:flutter/material.dart';

//widget to create icon similar to whatsapp
Widget iconCreation(IconData icon, Color color, String text) {
  return InkWell(
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        Text(text)
      ],
    ),
    onTap: () {},
  );
}
