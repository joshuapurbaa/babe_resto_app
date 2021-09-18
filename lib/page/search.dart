import '../common/consts.dart';
import '../common/styles.dart';
import '../data/api/api_services.dart';
import '../data/providers/search_provider.dart';
import '../page/detail.dart';
import '../widgets/remove_scroll_glow.dart';
import '../widgets/search_alert.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/search';

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Provider.of<RestaurantSearchProvider>(
      context,
      listen: false,
    ).fetchSearch();
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              child: Image.asset(
                'assets/images/background_search_page.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                children: [
                  Consumer<RestaurantSearchProvider>(
                    builder: (context, state, _) {
                      return SafeArea(
                        child: TextField(
                          style: theme.textTheme.bodyText1!.copyWith(
                            color: blackColor,
                          ),
                          controller: _searchController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Ampiran Kota',
                            hintStyle:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: greyColor.withOpacity(0.7),
                                    ),
                            isCollapsed: true,
                            contentPadding: EdgeInsets.all(10.0),
                            filled: true,
                            fillColor: whiteColor,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: whiteColor,
                              ),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: blackColor,
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _searchController.clear();
                                      state.fetchSearch(query: '');
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: blackColor,
                                    ),
                                  )
                                : null,
                          ),
                          onChanged: (query) {
                            state.fetchSearch(query: query);
                          },
                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: Consumer<RestaurantSearchProvider>(
                      builder: (context, state, _) {
                        if (state.state == ResultState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: yellowColor,
                            ),
                          );
                        } else if (state.state == ResultState.Searching) {
                          return Center(
                            child: BorderedText(
                              strokeCap: StrokeCap.round,
                              strokeColor: whiteColor,
                              child: Text(
                                'Cari restaurant',
                                style: theme.textTheme.headline6!.copyWith(
                                  color: theme.accentColor,
                                ),
                              ),
                            ),
                          );
                        } else if (state.state == ResultState.HasData) {
                          return ListView.builder(
                            padding:
                                EdgeInsets.symmetric(vertical: defaultPadding),
                            itemExtent: 120,
                            itemCount: state.searchResto!.details!.length,
                            itemBuilder: (context, index) {
                              final restaurant =
                                  state.searchResto!.details![index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RestaurantDetailPage.routeName,
                                    arguments: restaurant.id,
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Stack(
                                            children: [
                                              Image.network(
                                                ApiServices.imageUrl +
                                                    restaurant.pictureId!,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color: greyColor
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/icon-star.png',
                                                        width: 15,
                                                      ),
                                                      SizedBox(width: 2),
                                                      Text(
                                                        restaurant.rating
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              color: whiteColor,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              restaurant.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(color: blackColor),
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'assets/icons/icon-location.png',
                                                  width: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  restaurant.city!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                        color: blackColor,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.chevron_right_rounded,
                                          color: yellowColor,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (state.state == ResultState.NoData) {
                          return SearchAlert(
                            text: 'Yang kamu cari belum tersedia',
                            animation: 'assets/lotie_animation/not-found.json',
                          );
                        } else if (state.state == ResultState.Error) {
                          return SearchAlert(
                            text: 'Periksa kembali koneksi internet kamu',
                            animation:
                                'assets/lotie_animation/no-connection.json',
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
