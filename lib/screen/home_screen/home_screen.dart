import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wallpaper_app/widgets/build_images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List wallpaperImage = [
    'assets/images/wallpaper1.jpg',
    'assets/images/wallpaper2.jpg',
    'assets/images/wallpaper3.jpg',
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          'assets/images/man.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 75,
                    ),
                    const Text(
                      'Wallify',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                CarouselSlider.builder(
                  itemCount: wallpaperImage.length,
                  itemBuilder: (context, index, realIndex) {
                    final res = wallpaperImage[index];
                    return buildImages(res, index, context);
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height / 1.5,
                    // viewportFraction: 1,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: buildIndicators()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicators() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 3,
        effect: JumpingDotEffect(
          dotWidth: 15,
          dotHeight: 15,
          activeDotColor: Colors.blue,
        ),
      );
}
