import 'dart:ui';

import 'package:flutter/material.dart';
class GlassBox extends StatelessWidget {
  const GlassBox({super.key, required this.height, required this.width, required this.child,  this.sigmaY = 5, this.sigmaX = 5, this.borderSide = Colors.white, this.leftGradient=Colors.white, this.rightGradient=Colors.white});
  final double height;
  final double width;
  final Widget child;
  final double sigmaY;
  final double sigmaX;
  final Color borderSide;
  final Color leftGradient;
  final Color rightGradient;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:BorderRadius.circular(20),
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: sigmaY,
                  sigmaX:sigmaX
                ),
              child: Container(),
            ),

            Container(

              decoration: BoxDecoration(
                border: Border.all(color: borderSide),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    leftGradient,
                    rightGradient
                  ]
                )
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
