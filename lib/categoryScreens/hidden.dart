import 'package:flutter/material.dart';

class HiddenScreen extends StatefulWidget {
  const HiddenScreen({super.key});

  @override
  State<HiddenScreen> createState() => _HiddenScreenState();
}

class _HiddenScreenState extends State<HiddenScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}