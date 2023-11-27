import 'dart:io';

import 'package:flutter/material.dart';

class ExpenseSplitor extends StatefulWidget {
  ExpenseSplitor({required this.place});
  String place;

  @override
  State<ExpenseSplitor> createState() => _ExpenseSplitorState();
}

class _ExpenseSplitorState extends State<ExpenseSplitor> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Padding(padding: EdgeInsets.only(top: 40,left: 150),
            child: Text('hyyyy',
            style: TextStyle(
              fontFamily: 'kanit',
              fontSize: 24,
              color: Colors.white,
            ),
            ),),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 21, 21),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            height: 250,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(
              height: 800,
              width: double.infinity,
              color: Colors.yellow,
              child: Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 140),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Budget'),
                  Text('tripInfo.plannedAmount!')
                ],
              ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/planTrip4.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey, width: 3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
