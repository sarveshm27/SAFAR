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
          width: screenSize.width * 0.8, // 80% of the screen width
          height: screenSize.width * 0.8, // 80% of the screen width (to maintain aspect ratio)
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
                title1: "Multi-Modal Ticketing",
                description1: "Multi-modal ticketing enables passengers to use a single ticket or payment method across various transportation modes, streamlining travel and simplifying transfers.",
                imagePath1: 'assets/feature1.gif',
                title2: "Feature 1B",
                description2: "Description of Feature 1B.",
                imagePath2: 'assets/feature1b.png',
              ),
              _buildIntroSlide(
                title1: "Feature 2A",
                description1: "Description of Feature 2A.",
                imagePath1: 'assets/feature2a.png',
                title2: "Feature 2B",
                description2: "Description of Feature 2B.",
                imagePath2: 'assets/feature2b.png',
              ),
              _buildIntroSlide(
                title1: "Feature 3A",
                description1: "Description of Feature 3A.",
                imagePath1: 'assets/feature3a.png',
                title2: "Feature 3B",
                description2: "Description of Feature 3B.",
                imagePath2: 'assets/feature3b.png',
              ),
            ],
          ),
          Positioned(
            bottom: 60,
            child: _currentPage == 2
                ? TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                : Container(
                    child: SmoothPageIndicator(
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
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSlide({
    required String title1,
    required String description1,
    required String imagePath1,
    required String title2,
    required String description2,
    required String imagePath2,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildFeature(
                    title: title1,
                    description: description1,
                    imagePath: imagePath1,
                    alignment: CrossAxisAlignment.start,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: _buildFeature(
                    title: title2,
                    description: description2,
                    imagePath: imagePath2,
                    alignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature({
    required String title,
    required String description,
    required String imagePath,
    required CrossAxisAlignment alignment,
  }) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(seconds: 2),
          builder: (context, double value, child) {
            return Opacity(
              opacity: value,
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: alignment,
            children: [
              Image.asset(imagePath),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
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
