import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/chats_list/screen/mobile_screen_layout.dart';
import 'package:whatsapp_clone/splash/screen/splash_screen.dart';
import 'package:whatsapp_clone/widgets/colors.dart';
import 'package:whatsapp_clone/widgets/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        //Custom theme for scaffold Background color and appBar color for whole app
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(
            color: appBarColor,
          ),
        ),

        //connecting to router.dart file
        onGenerateRoute: (settings) => generateRoute(settings),

        //used animated_splash_screen package for splash screen with fade animation
        home: AnimatedSplashScreen(
          splash: const SplashScreen(),
          backgroundColor: backgroundColor,
          nextScreen: const MobileScreenLayout(),
          pageTransitionType: PageTransitionType.fade,
        ));
  }
}
