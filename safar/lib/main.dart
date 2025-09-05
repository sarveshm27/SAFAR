import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}

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
        builder: (context) => const OnboardingScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          // Set the width and height as a proportion of the screen size
          width: screenSize.width * 0.6, // 60% of the screen width
          height: screenSize.width * 0.6, // 60% of the screen width (to maintain aspect ratio)
          child: Image.asset('assets/neumo.gif'),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: [
              _buildIntroSlide(
                title: "Any Transport",
                description: "Multi-modal ticketing enables passengers to use a single ticket or payment method across various transportation modes, streamlining travel and simplifying transfers.",
                imagePath: 'assets/feature1.gif',
                screenSize: screenSize, // Pass the screen size
              ),
              _buildIntroSlide(
                title: "Quick and Easy Access",
                description: "Online transportation ticketing is a system that allows users to book and purchase tickets for various modes of transportation—such as buses, trains, flights, and ferries—via the internet",
                imagePath: 'assets/eature.gif',
                screenSize: screenSize, // Pass the screen size
              ),
              _buildIntroSlide(
                title: "Easy Ticketing",
                description: "Online transportation ticketing provides a convenient and hassle-free way to book travel tickets, offering users the flexibility to choose routes, compare prices, and secure their seats from anywhere at any time with just a few clicks.",
                imagePath: 'assets/ature.gif',
                screenSize: screenSize, // Pass the screen size
              ),
            ],
          ),
          Positioned(
            bottom: 60,
            child: _currentPage == 2
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.white, Colors.white70],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const WormEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.white,
                      dotHeight: 12,
                      dotWidth: 12,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSlide({
    required String title,
    required String description,
    required String imagePath,
    required Size screenSize,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          // Adjust the size of the GIF
          width: 300, // 60% of the screen width
          height: 300, // 60% of the screen width
          child: Image.asset(imagePath),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Text("Welcome to the Home Page!"),
      ),
    );
  }
}
