import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/screens/bottom_menu_screens/search_place.dart';
import 'package:travel_mate/screens/sideMenuScreens/home_side_menu.dart';

class homeAppBar extends StatefulWidget {
  const homeAppBar({super.key});

  @override
  State<homeAppBar> createState() => _homeAppBarState();
}

class _homeAppBarState extends State<homeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: SideMenu(),
                  type: PageTransitionType.leftToRight,
                  duration: Duration(milliseconds: 600),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.sort_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              Text(
                "India, IND",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchedPlace();
              },));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
