import 'package:babe_resto/common/styles.dart';
import 'package:flutter/material.dart';

class MenuTitle extends StatelessWidget {
  final String textTitle;
  MenuTitle({required this.textTitle});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Text(
          textTitle,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 22,
                fontWeight: bold,
              ),
        ),
      ),
    );
  }
}
