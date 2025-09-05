import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      body: Center(
        child: SizedBox(
          // Set the width and height as a proportion of the screen size
          width: screenSize.width * 0.8, // 80% of the screen width
          height: screenSize.width * 0.8, // 80% of the screen width (to maintain aspect ratio)
          child: Image.asset('assets/neumo.gif'),
        ),
      ),
    );
  }
}
