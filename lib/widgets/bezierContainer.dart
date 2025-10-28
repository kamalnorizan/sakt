// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Transform.rotate(
        angle: -pi / 3.5,
        child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height * .8,
            width: MediaQuery.of(context).size.width * 1.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 209, 93, 4),
                  Color.fromARGB(255, 246, 221, 161),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
