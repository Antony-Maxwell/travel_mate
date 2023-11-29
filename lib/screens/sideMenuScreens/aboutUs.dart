import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        title: Text('About Us',
        style: TextStyle(
          color: Colors.white,
        ),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 150,),
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
                  'More about us',
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
          ),
          SizedBox(height: 200,),
           Text(
            'Any Queries ? feel free to contact us ',
            style: TextStyle(
              color: Colors.white,
            ),
            ),
            TextButton(onPressed: (){

            }, child: Text(
              'travelMate@gmail.com',
            ))
          ],
        ),
      ),
    );
  }
}