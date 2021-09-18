import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AlertWidget extends StatelessWidget {
  final String animation;
  final String text;
  final Widget? action;
  const AlertWidget({
    required this.text,
    this.action,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            animation,
            width: 180,
            height: 180,
          ),
          SizedBox(height: 20),
          Container(
            width: 220.0,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          SizedBox(height: 20.0),
          action != null ? action! : SizedBox(),
        ],
      ),
    );
  }
}
