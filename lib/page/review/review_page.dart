import 'package:babe_resto/common/consts.dart';
import 'package:babe_resto/common/styles.dart';
import 'package:babe_resto/data/models/review.dart';
import 'package:babe_resto/data/providers/detail_provider.dart';
import 'package:babe_resto/page/review/tulis_review.dart';
import 'package:babe_resto/widgets/remove_scroll_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatelessWidget {
  static const routeName = '/review_page';
  final String id;
  const ReviewPage({required this.id});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Provider.of<RestaurantDetailProvider>(
      context,
      listen: false,
    ).fetchDetail(id);
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: redColor,
          ),
        ),
        title: Text(
          'Ulasan dan rating',
          style: theme.textTheme.subtitle1!
              .copyWith(fontWeight: extraBold, color: theme.accentColor),
        ),
      ),
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
              return Container(
                child: _buildReview(
                  context: context,
                  reviews: restaurant!.customerReviews!,
                  rating: restaurant.rating!,
                ),
              );
            } else if (state.state == ResultState.NoData) {
              return Text('Data belum ada');
            } else if (state.state == ResultState.Error) {
              return Text('Koneksi gagal, coba ulangi');
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildReview({
    required BuildContext context,
    required List<CustomerReview> reviews,
    required double rating,
  }) {
    var theme = Theme.of(context);
    return ListView(
      padding: EdgeInsets.all(defaultPadding),
      children: [
        Card(
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          rating.toString(),
                          style: theme.textTheme.headline4!.copyWith(
                            color: theme.secondaryHeaderColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.info),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Total review ${reviews.length.toString()}',
                      style: theme.textTheme.caption,
                    ),
                  ],
                ),
                RatingBar.builder(
                  itemSize: 30,
                  initialRating: rating,
                  allowHalfRating: true,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  unratedColor: Colors.grey.withOpacity(0.5),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Apa kata pelanggan',
          style: theme.textTheme.subtitle1!.copyWith(
            fontWeight: semiBold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: [
            for (var review in reviews)
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name!,
                            style: theme.textTheme.subtitle1!.copyWith(
                              fontWeight: bold,
                            ),
                          ),
                          Text(
                            review.review!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyText1,
                          ),
                          Text(
                            'Dipesan tanggal ${review.date!}',
                            style: theme.textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              TulisReview.routeName,
              arguments: id,
            );
          },
          child: Text(
            'Tulis review',
            style: theme.textTheme.subtitle1!.copyWith(
              color: theme.accentColor,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: yellowColor,
          ),
        ),
      ],
    );
  }
}
