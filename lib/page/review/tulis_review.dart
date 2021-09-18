import 'package:babe_resto/common/consts.dart';
import 'package:babe_resto/common/styles.dart';
import 'package:babe_resto/data/providers/detail_provider.dart';
import 'package:babe_resto/data/providers/review_provider.dart';
import 'package:babe_resto/page/review/review_page.dart';
import 'package:babe_resto/widgets/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TulisReview extends StatelessWidget {
  static const routeName = '/tulis_review';

  final String id;
  const TulisReview({required this.id});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Widget _buildContent({required BuildContext context}) {
      final TextEditingController _nameController = TextEditingController();
      final TextEditingController _reviewController = TextEditingController();

      final _formKey = GlobalKey<FormState>();
      var theme = Theme.of(context);
      return Consumer<RestaurantReviewProvider>(
        builder: (context, state, _) {
          if (state.state == Post.Idle) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Card(
                            child: TextFormField(
                              controller: _nameController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(defaultPadding),
                                isCollapsed: true,
                                hintText: 'Nama',
                                hintStyle: theme.textTheme.bodyText2,
                                filled: true,
                                fillColor: theme.primaryColorLight,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: yellowColor,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama masih kosong';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Card(
                            child: TextFormField(
                              controller: _reviewController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              textAlign: TextAlign.justify,
                              decoration: InputDecoration(
                                hintText: 'Masukan Review kamu',
                                hintStyle: theme.textTheme.bodyText2,
                                isCollapsed: true,
                                contentPadding: EdgeInsets.all(defaultPadding),
                                filled: true,
                                fillColor: theme.primaryColorLight,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: yellowColor,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Review masih kosong';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              state.postReviewByRestoId(
                                id: id,
                                name: _nameController.text,
                                review: _reviewController.text,
                              );
                            }
                          },
                          child: Text(
                            'Beri Review',
                            style: theme.textTheme.subtitle1!.copyWith(
                              color: theme.accentColor,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: yellowColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state.state == Post.Loading) {
            return Center(
              child: CircularProgressIndicator(
                color: yellowColor,
              ),
            );
          } else if (state.state == Post.Success) {
            return AlertWidget(
              animation: 'assets/lotie_animation/checklist.json',
              text: 'Terimakasih, Review kamu berhasil ditambahkan!',
              action: SizedBox(
                width: 220.0,
                child: TextButton(
                  onPressed: () {
                    Provider.of<RestaurantDetailProvider>(
                      context,
                      listen: false,
                    ).fetchDetail(id);

                    state.setState(Post.Idle);

                    Navigator.of(context).popUntil(
                      ModalRoute.withName(ReviewPage.routeName),
                    );
                  },
                  child: Text(
                    'Kembali',
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
          } else if (state.state == Post.Error) {
            return AlertWidget(
              animation: 'assets/lotie_animation/no-connection.json',
              text: 'Koneksi gagal, coba ulangi',
              action: SizedBox(
                width: 200.0,
                child: TextButton(
                  onPressed: () {
                    state.setState(Post.Idle);
                  },
                  child: Text(
                    'Refresh',
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
          } else {
            return SizedBox();
          }
        },
      );
    }

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
          style: theme.textTheme.subtitle1!.copyWith(
            fontWeight: extraBold,
            color: theme.accentColor,
          ),
        ),
      ),
      body: _buildContent(context: context),
    );
  }
}
