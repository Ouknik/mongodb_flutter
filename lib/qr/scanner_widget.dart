import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extenstion.dart';

class ScannerAnimation extends AnimatedWidget {
  final bool stopped;
  final double width;

  ScannerAnimation(
    this.stopped,
    this.width, {
    Key? key,
    required Animation<double> animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final scorePosition =
        (animation.value * MediaQuery.of(context).size.height * 0.39) +
            MediaQuery.of(context).size.height * 0.24;
    Color color1 = HexColor.fromHex("#09B5F0");
    Color color2 = HexColor.fromHex("#09B5F0");

    return new Positioned(
      bottom: scorePosition,
      left: MediaQuery.of(context).size.width * 0.1,
      child: new Opacity(
        opacity: (stopped) ? 0.0 : 0.6,
        child: Container(
          height: 2.0,
          width: width,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.9],
              colors: [color1, color2],
            ),
          ),
        ),
      ),
    );
  }
}
