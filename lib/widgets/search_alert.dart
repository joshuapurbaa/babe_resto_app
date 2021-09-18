import 'package:babe_resto/common/styles.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchAlert extends StatelessWidget {
  final String animation;
  final String text;
  const SearchAlert({
    required this.text,
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
          BorderedText(
            strokeCap: StrokeCap.round,
            strokeColor: whiteColor,
            child: Text(
              text,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: redColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
