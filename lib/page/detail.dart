import '../common/consts.dart';
import '../common/styles.dart';
import '../data/api/api_services.dart';
import '../data/models/category.dart';
import '../data/models/list_restaurant.dart';
import '../data/providers/detail_provider.dart';
import '../page/review/review_page.dart';
import '../widgets/alert_widget.dart';
import '../widgets/favorite_button.dart';
import '../widgets/menu_title.dart';
import '../widgets/menus_grid.dart';
import '../widgets/remove_scroll_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final String id;
  const RestaurantDetailPage({required this.id});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    SizedBox sizedBox10 = SizedBox(height: 10);
    var theme = Theme.of(context);
    Widget _buildCategories({required List<Category> categories}) {
      return Row(
        children: [
          for (var category in categories)
            Container(
              margin: EdgeInsets.only(right: 8.0),
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                category.name!,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: blackColor,
                    ),
              ),
            ),
        ],
      );
    }

    Provider.of<RestaurantDetailProvider>(
      context,
      listen: false,
    ).fetchDetail(widget.id);

    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: yellowColor,
                ),
              );
            } else if (state.state == ResultState.HasData) {
              final restaurant = state.detailResto!.detail;
              final restoForFav = new Restaurant(
                id: restaurant?.id,
                name: restaurant?.name,
                description: restaurant?.description,
                pictureId: restaurant?.pictureId,
                city: restaurant?.city,
                rating: restaurant?.rating,
              );
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: restaurant!.id!,
                        child: Image.network(
                          '${ApiServices.largeImageUrl}${restaurant.pictureId}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                      color: redColor,
                      iconSize: 40,
                    ),
                    actions: [
                      FavoriteButton(
                        favsRestaurant: restoForFav,
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name!,
                                  style: theme.textTheme.headline4!.copyWith(
                                    color: theme.secondaryHeaderColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/icon-location.png',
                                      width: 12,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      restaurant.city!,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Spacer(),
                                    RatingBar.builder(
                                      itemSize: 20,
                                      initialRating: restaurant.rating!,
                                      allowHalfRating: true,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      unratedColor:
                                          Colors.grey.withOpacity(0.5),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      restaurant.rating.toString(),
                                      style: theme.textTheme.caption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: greyColor.withOpacity(0.5),
                            thickness: 0.2,
                          ),
                          SizedBox(height: 10),
                          _buildCategories(categories: restaurant.categories!),
                          sizedBox10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Deskripsi',
                                style: theme.textTheme.subtitle1,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    ReviewPage.routeName,
                                    arguments: widget.id,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: yellowColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Reviews',
                                    style: theme.textTheme.button!
                                        .copyWith(color: theme.accentColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                          sizedBox10,
                          Text(restaurant.description!),
                          SizedBox(height: 10),
                          Divider(
                            color: greyColor.withOpacity(0.5),
                            thickness: 0.2,
                          ),
                          sizedBox10,
                          Text(
                            'Daftar Menu',
                            style: theme.textTheme.subtitle1,
                          ),
                          sizedBox10,
                        ],
                      ),
                    ),
                  ),
                  MenuTitle(
                    textTitle: 'Makanan',
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: 10),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item =
                              state.detailResto!.detail!.menus!.foods![index];
                          return MenusGrid(
                            item: item,
                            images: 'assets/images/foods.jpg',
                          );
                        },
                        childCount:
                            state.detailResto!.detail!.menus!.foods!.length,
                      ),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.0,
                      ),
                    ),
                  ),
                  MenuTitle(
                    textTitle: 'Minuman',
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding, vertical: 10),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item =
                              state.detailResto!.detail!.menus!.drinks![index];
                          return MenusGrid(
                            item: item,
                            images: 'assets/images/drinks.jpg',
                          );
                        },
                        childCount:
                            state.detailResto!.detail!.menus!.drinks!.length,
                      ),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.0,
                      ),
                    ),
                  ),
                  // _buildFab(),
                ],
              );
            } else if (state.state == ResultState.NoData) {
              return AlertWidget(
                text: 'List restaurant belum tersedia',
                animation: 'assets/lottie_animation/not-found.json',
              );
            } else if (state.state == ResultState.Error) {
              return AlertWidget(
                text: 'Periksa kembali koneksi internet kamu',
                animation: 'assets/lotie_animation/no-connection.json',
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
