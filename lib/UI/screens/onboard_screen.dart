import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide/UI/screens/home_screen.dart';
import 'package:slide/models/onboard_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // List <OnboardModel> contents = [];

  List<OnboardModel> contents = [
    OnboardModel(
        title: "Trial Title",
        image: "images/123.svg ",
        description: "Trial Description"),
    OnboardModel(
        title: "Trial Title",
        image: "images/123.svg ",
        description: "Trial Description"),
    OnboardModel(
        title: "Trial Title",
        image: "images/123.svg ",
        description: "Trial Description"),
  ];
  int currentIndex = 0;
  PageController _pageController = PageController();
  @override
  initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        contents[i].image,
                        height: 300,
                      ),
                      Text(
                        contents[i].title,
                        style: const TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        contents[i].description,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
              onPageChanged: (int index) {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
            ),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                )
              ],
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            color: Colors.blue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
              child: Text(
                currentIndex == contents.length - 1 ? "Continue" : "Next",
              ),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyHomePage(),
                    ),
                  );
                  _pageController.nextPage(
                    duration: const Duration(
                      milliseconds: 100,
                    ),
                    curve: Curves.bounceIn,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
        height: 10,
        width: currentIndex == index ? 30 : 10,
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ));
  }
}
