import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/categories/all_wallpaper.dart';
import 'package:wallpaper_app/screen/categories/widgets/category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              // Category Text
              const Center(
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllWallpaperScreen(category: 'Wild Life'),));
                },
                child: CategoryWidget(
                  categoryName: 'WildLife',
                  categoryImage: 'assets/images/wallpaper1.jpg',
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllWallpaperScreen(category: 'Food'),));
                },
                child: CategoryWidget(
                  categoryName: 'Foods',
                  categoryImage: 'assets/images/wallpaper2.jpg',
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllWallpaperScreen(category: 'City'),));
                },
                child: CategoryWidget(
                  categoryName: 'City',
                  categoryImage: 'assets/images/wallpaper3.jpg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
