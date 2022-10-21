import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class AuthanticationLoadingScreen extends StatefulWidget {
  const AuthanticationLoadingScreen({super.key});

  @override
  State<AuthanticationLoadingScreen> createState() =>
      _AuthanticationLoadingScreenState();
}

class _AuthanticationLoadingScreenState
    extends State<AuthanticationLoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: Colors.blueGrey,
        child: Text(
          'Loading',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));
  }
}
