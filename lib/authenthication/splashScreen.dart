import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/provider/providerClass.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class splashScreen extends StatefulWidget {
  splashScreen({super.key});

  @override
  State<splashScreen> createState() => splashScreenState();
}

class splashScreenState extends State<splashScreen> {
  static const String KEYLOGIN = "login";
  static const String ISADMINLOGGED = "admin";

// @override
// void initState() {
//   super.initState();
//   _loadUsername();
//     whereToGo();
// }

  @override
  Widget build(BuildContext context) {
    getfavPlace();
    getPlannedTrip();
    return Scaffold(
      body: Center(
        child: Stack(children: <Widget>[
          Container(
            height: 900,
            width: 450,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black
                    .withOpacity(0.5), // Adjust the opacity value as needed
                BlendMode.srcOver,
              ),
              child: Image.asset(
                "assets/images/splashImage.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 120,
            child: Text(
              'Start Your\nJourney',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: "RobotoSlab",
              ),
            ),
          ),
          Positioned(
            top: 600,
            left: 120,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: TextButton(
                onPressed: () {
                  whereToGo();
                },
                child: Text(
                  'Tap to continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    var sharedPrefs = await SharedPreferences.getInstance();
    var isAdmin = sharedPrefs.getBool(ISADMINLOGGED);
    await _loadUsername();
    // Timer(Duration(seconds: 3), () {
    if (isLoggedIn != null) {
      if (isLoggedIn) {
        if (isAdmin != null && isAdmin) {
          // Navigate to admin panel
          navigatorKey.currentState!.pushReplacementNamed('/adminMain');
        } else {
          // Navigate to user's page
          navigatorKey.currentState!.pushReplacementNamed('/bottomMenu');
        }
      } else {
        // Navigate to login
        navigatorKey.currentState!.pushReplacementNamed('/login');
      }
    } else {
      // Navigate to login
      navigatorKey.currentState!.pushReplacementNamed('/login');
    }
    // });
  }

  _loadUsername() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final username = sharedPrefs.getString('username') ?? 'DefaultUsername';

    // Update the UserProvider with the username
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(Users(username: username));

    // Navigate to the appropriate screen (e.g., login or home) based on whether a username is available
    if (username == 'DefaultUsername') {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      Navigator.pushReplacementNamed(context, '/bottomMenu');
    }
  }
}
