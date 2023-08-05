import 'dart:io';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// functions that will be used by multiple parts/screens

// used to show snackBar
void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

//function used to pick image from gallery and return the picked image
Future<File?> pickImageGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

//function used to pick video from gallery and return the picked video
Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}

//function used to pick gif from Giphy and return the picked gif
//this Giphy is from enough_giphy_flutter package
Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    //apikey is provided by Giphy for developers
    gif = await Giphy.getGif(
        context: context, apiKey: 'lcMahDR0uAoGu1aZJIYfZJvPxnR7oEji');
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return gif;
}
