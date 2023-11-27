import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
          ),
          Text(
            'Admin Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          Icon(
            Icons.admin_panel_settings,
            color: Colors.white,
            size: 150,
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15),
                ),
                Text(
                  'Admin console',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "A travel assistant application is your all-in-one companion for a seamless and enjoyable travel experience. Whether you're embarking on a vacation, a business trip, or any other travel adventure, this app is designed to make your journey stress-free and memorable.",
                      style: TextStyle(
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'travel mate.\n     1.0',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
