import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:travel_mate/screens/bottom_menu_screens/googleMap.dart';
import 'package:travel_mate/screens/bottom_menu_screens/planTrip.dart';
import 'package:travel_mate/screens/bottom_menu_screens/saved_location.dart';
import 'package:travel_mate/screens/bottom_menu_screens/user_home.dart';
import 'package:travel_mate/screens/bottom_menu_screens/user_add_location.dart';

class homeBottomBar extends StatefulWidget {
  const homeBottomBar({super.key});

  @override
  State<homeBottomBar> createState() => _homeBottomBarState();
}

class _homeBottomBarState extends State<homeBottomBar> {
  int _page = 2;
  final PageController _pageController = PageController(initialPage: 2);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // Disable sliding effect
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color.fromARGB(255, 35, 35, 35),
        index: _page,
        color: Color.fromARGB(255, 0, 0, 0),
        buttonBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        onTap: (index) {
          setState(() {
            _page = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          Icon(
            Icons.add_road_outlined,
            color: _page == 0
                ? Color.fromARGB(255, 0, 119, 255)
                : const Color.fromARGB(255, 255, 255,
                    255), // Change the color based on the selected page
          ),
          Icon(
            Icons.favorite_outline_outlined,
            color: _page == 1
                ? Color.fromARGB(255, 0, 119, 255)
                : const Color.fromARGB(255, 255, 255,
                    255), // Change the color based on the selected page
          ),
          Icon(
            Icons.home_outlined,
            color: _page == 2
                ? Color.fromARGB(255, 0, 119, 255)
                : const Color.fromARGB(255, 255, 255,
                    255), // Change the color based on the selected page
          ),
          Icon(
            Icons.location_on_outlined,
            color: _page == 3
                ? Color.fromARGB(255, 0, 119, 255)
                : const Color.fromARGB(255, 255, 255,
                    255), // Change the color based on the selected page
          ),
          Icon(
            Icons.add_location_alt_outlined,
            color: _page == 4
                ? Color.fromARGB(255, 0, 119, 255)
                : const Color.fromARGB(255, 255, 255,
                    255), // Change the color based on the selected page
          ),
        ],
      ),
    );
  }

  final List<Widget> _pages = [
    userDetails(),
    savedPage(),
    userMain(),
    location_googleMap(placeName: ''),
    addLocation_user(),
  ];
}
