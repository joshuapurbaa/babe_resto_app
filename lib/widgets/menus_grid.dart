import 'package:babe_resto/common/styles.dart';
import 'package:babe_resto/data/models/category.dart';
import 'package:flutter/material.dart';

class MenusGrid extends StatelessWidget {
  const MenusGrid({
    Key? key,
    required this.item,
    required this.images,
  }) : super(key: key);

  final Category item;
  final String images;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                images,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: greyColor.withOpacity(0.7),
          ),
          child: Text(
            item.name!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: whiteColor,
                  fontWeight: semiBold,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
