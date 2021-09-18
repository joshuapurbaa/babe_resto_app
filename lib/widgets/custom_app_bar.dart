import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:babe_resto/common/styles.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
      automaticallyImplyLeading: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      elevation: 0,
      flexibleSpace: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/header_background.jpg'),
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: defaultPadding),
                child: BorderedText(
                  strokeCap: StrokeCap.round,
                  strokeColor: whiteColor,
                  child: Text(
                    'Babe Resto',
                    style: theme.textTheme.headline4!.copyWith(
                      color: theme.accentColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              // const SizedBox(width: 20.0),
              Expanded(
                child: DefaultTextStyle(
                  style: theme.textTheme.headline3!.copyWith(
                    color: theme.accentColor,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      RotateAnimatedText('Restoran'),
                      RotateAnimatedText('Makanan'),
                      RotateAnimatedText('Minuman'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
