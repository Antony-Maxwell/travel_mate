import 'package:flutter/material.dart';

class adminAppBar extends StatelessWidget {
  const adminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Admin Dashboard',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        IconButton(onPressed: (){
          Navigator.popAndPushNamed(context, '/login');
        }, icon: Icon(Icons.logout,
        color: Colors.white,),)
      ],
    ),);
  }
}