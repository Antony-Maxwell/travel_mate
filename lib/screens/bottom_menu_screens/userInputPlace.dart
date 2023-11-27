import 'package:flutter/material.dart';

class myInput extends StatefulWidget {
  final controller;
  final String hint;
  const myInput({super.key, required this.controller, required this.hint});

  @override
  State<myInput> createState() => _myInputState();
}

class _myInputState extends State<myInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 280,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0))
              ),
              fillColor: Colors.white.withOpacity(.2),
              filled: true,
              hintText: widget.hint,
              hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))
            ),
          ),
        ),
      ],
    );
  }
}