import 'package:babe_resto/common/styles.dart';
import 'package:babe_resto/data/models/list_restaurant.dart';
import 'package:babe_resto/data/providers/database_provider.dart';
import 'package:babe_resto/page/favorite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    required this.favsRestaurant,
  });

  final Restaurant favsRestaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DbProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavsResto(favsRestaurant.id!),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return isFavorite
                ? IconButton(
                    padding: EdgeInsets.only(right: 8),
                    onPressed: () {
                      provider.removeFavorite(favsRestaurant.id!);
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 40,
                    ),
                    color: Theme.of(context).accentColor,
                  )
                : IconButton(
                    padding: EdgeInsets.only(right: 8),
                    onPressed: () {
                      provider.addFavsResto(favsRestaurant);
                      showActionSnackBar(context);
                    },
                    icon: Icon(
                      Icons.favorite_border_rounded,
                      size: 40,
                    ),
                    color: Theme.of(context).accentColor,
                  );
          },
        );
      },
    );
  }
}

void showActionSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: Text(
      'Berhasil ditambahkan ke daftar favorit',
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: blackColor,
          ),
    ),
    backgroundColor: Colors.grey[100],
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Lihat',
      textColor: redColor,
      onPressed: () {
        Navigator.pushNamed(
          context,
          FavoriteRestaurantPage.routeName,
        );
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
