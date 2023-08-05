import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          //responsive image size
          //values are done by lot of trials
          height: size.height * 0.15,
          width: size.height * 0.15,
          child: Image.asset("lib/assets/images/whatsapp_logo.png"),
        ),
      ),
    );
  }
}
