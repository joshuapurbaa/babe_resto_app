import 'package:babe_resto/page/bottom_nav.dart';
import 'package:babe_resto/widgets/remove_scroll_glow.dart';

import '../common/consts.dart';
import '../common/styles.dart';
import '../data/api/api_services.dart';
import '../data/models/list_restaurant.dart';
import '../data/providers/database_provider.dart';
import '../page/detail.dart';
import '../widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteRestaurantPage extends StatelessWidget {
  static const routeName = '/favorite';
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Favorite Restaurant',
          style: theme.textTheme.subtitle1!
              .copyWith(fontWeight: extraBold, color: theme.accentColor),
        ),
      ),
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: Consumer<DbProvider>(
          builder: (context, provider, child) {
            if (provider.state == ResultState.HasData) {
              return ListView.builder(
                itemCount: provider.favorites.length,
                itemBuilder: (context, index) {
                  Restaurant resto = provider.favorites[index];
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RestaurantDetailPage.routeName,
                        arguments: resto.id,
                      );
                    },
                    leading: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            ApiServices.imageUrl + resto.pictureId!,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            height: 20,
                            decoration: BoxDecoration(
                              color: greyColor.withOpacity(0.7),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/icons/icon-star.png',
                                  width: 15,
                                ),
                                SizedBox(width: 2),
                                Text(
                                  resto.rating.toString(),
                                  style: theme.textTheme.bodyText2!.copyWith(
                                    fontWeight: medium,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      resto.name!,
                      style: theme.textTheme.bodyText1,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/icon-location.png',
                              width: 10,
                              color: greyColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              resto.city!,
                              style: theme.textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: FavoriteButton(
                      favsRestaurant: resto,
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      provider.message,
                      style: theme.textTheme.subtitle2!.copyWith(
                        color: theme.secondaryHeaderColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            BottomNav.routeName,
                          );
                        },
                        child: Text(
                          'Tambahkan',
                          style: theme.textTheme.subtitle1!.copyWith(
                            color: theme.accentColor,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: yellowColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
