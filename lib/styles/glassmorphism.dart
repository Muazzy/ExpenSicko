import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  const GlassMorphism({
    Key? key,
    required this.child,
    required this.start,
    required this.end,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(start),
                  Colors.white.withOpacity(end),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // border: Border(
              //   bottom: BorderSide(
              //     color: Colors.white.withOpacity(0.5),
              //     width: 1.5,
              //   ),
              //   left: BorderSide(
              //     color: Colors.white.withOpacity(0.5),
              //     width: 1,
              //   ),
              //   top: BorderSide(
              //     color: Colors.white.withOpacity(0.5),
              //     width: 1,
              //   ),
              //   right: BorderSide(
              //     color: Colors.white.withOpacity(0.5),
              //     width: 1.5,
              //   ),
              // ),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                // width: 1,
              )),
          child: child,
        ),
      ),
    );
  }
}
