import 'package:flutter/material.dart';
import 'package:whatsapp_clone/chat/screen/chat_screen.dart';
import 'package:whatsapp_clone/chats_list/screen/mobile_screen_layout.dart';
import 'package:whatsapp_clone/widgets/error_screen.dart';

//Route file
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    //route for ChatScreen
    case ChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final index = arguments['index'];
      return MaterialPageRoute(
        builder: (context) => ChatScreen(
          uid: uid,
          name: name,
          index: index,
        ),
      );

    //route for MobileScreenLayout
    case MobileScreenLayout.routeName:
      return MaterialPageRoute(
        builder: (context) => const MobileScreenLayout(),
      );

    //route for default to ErrorScreen
    default:
      return MaterialPageRoute(
          builder: (context) =>
              const ErrorScreen(error: "This page doesn't exist"));
  }
}
