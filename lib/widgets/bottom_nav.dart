import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/categories/category_screen.dart';
import 'package:wallpaper_app/screen/home_screen/home_screen.dart';
import 'package:wallpaper_app/screen/search/search_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentTabIndex = 0;

  late List<Widget> pages;
  late HomeScreen homeScreen;
  late CategoriesScreen categoriesScreen;
  late SearchScreen searchScreen;

  late Widget currentPage;

  @override
  void initState() {
    homeScreen = HomeScreen();
    searchScreen = SearchScreen();
    categoriesScreen = CategoriesScreen();

    pages = [homeScreen, searchScreen, categoriesScreen];
    currentPage = HomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        buttonBackgroundColor: Colors.black,
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 84, 87, 93),
        animationDuration: const Duration(milliseconds: 500),
        onTap: (value) {
          setState(() {
            currentTabIndex = value;
          });
        },
        items: [
          Icon(Icons.home_outlined, color: Colors.white,),
          Icon(Icons.search_outlined, color: Colors.white,),
          Icon(Icons.category_outlined, color: Colors.white,),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
