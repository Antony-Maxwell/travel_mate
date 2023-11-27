import 'package:flutter/material.dart';
import 'package:travel_mate/widgets/adminWidgets/admin_main_dashboard.dart';
import 'package:travel_mate/widgets/adminWidgets/admin_navigation_drawer.dart';

class adminMain extends StatelessWidget {
  const adminMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/LoginandSignUp.jpg'),
        fit: BoxFit.cover,
        opacity: 0.2)
      ),
      height: double.infinity,
      width: 500,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: adminNavigation(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        // bottomNavigationBar: adminBottom(),
        bottomNavigationBar: AdminDashboard(),
      ),
    );
  }
}
