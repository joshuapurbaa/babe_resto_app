import '../common/consts.dart';
import '../common/styles.dart';
import '../data/api/api_services.dart';
import '../data/providers/list_provider.dart';
import '../page/detail.dart';
import '../widgets/alert_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/remove_scroll_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantHomePage extends StatelessWidget {
  static const routeName = '/restaurant_home';

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Widget _restaurantList() {
      Provider.of<RestaurantListProvider>(context, listen: false).fetchList();
      return Consumer<RestaurantListProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.Loading) {
            return Center(
              child: CircularProgressIndicator(
                color: yellowColor,
              ),
            );
          } else if (state.state == ResultState.HasData) {
            return ListView.builder(
              itemCount: state.listResto!.details!.length,
              itemBuilder: (context, index) {
                final restaurant = state.listResto!.details![index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RestaurantDetailPage.routeName,
                      arguments: restaurant.id,
                    );
                  },
                  leading: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: restaurant.id!,
                          child: Image.network(
                            ApiServices.imageUrl + restaurant.pictureId!,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
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
                                restaurant.rating.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
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
                  title: Text(
                    restaurant.name!,
                    style: Theme.of(context).textTheme.bodyText1,
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
                            restaurant.city!,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: yellowColor,
                  ),
                );
              },
            );
          } else if (state.state == ResultState.NoData) {
            return AlertWidget(
              text: 'List restaurant belum tersedia',
              animation: 'assets/lottie_animation/not-found.json',
              action: SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: () {
                    state.fetchList();
                  },
                  child: Text(
                    'Segarkan',
                    style: theme.textTheme.subtitle1!.copyWith(
                      color: theme.accentColor,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: yellowColor,
                  ),
                ),
              ),
            );
          } else if (state.state == ResultState.Error) {
            return AlertWidget(
              text: 'Periksa kembali koneksi internet kamu',
              animation: 'assets/lotie_animation/no-connection.json',
              action: SizedBox(
                width: 200,
                child: TextButton(
                  onPressed: () {
                    state.fetchList();
                  },
                  child: Text(
                    'Segarkan',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: theme.accentColor,
                        ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: yellowColor,
                  ),
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(),
      ),
      body: ScrollConfiguration(
        behavior: MyBehaviour(),
        child: _restaurantList(),
      ),
    );
  }
}
