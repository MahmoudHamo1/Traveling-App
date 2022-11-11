import 'package:flutter/material.dart';
import 'package:lets_head_out/utils/Buttons.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';

import '../customer.dart';
import '../shop.dart';

class HotelOverViewScreen extends StatefulWidget {
  final Shop shop;

  const HotelOverViewScreen({Key key, this.shop}) : super(key: key);
  @override
  _HotelOverViewScreenState createState() => _HotelOverViewScreenState();
}

class _HotelOverViewScreenState extends State<HotelOverViewScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Customer customer;
  TextEditingController reviewController;
  ScrollController scrollController;
  Future getReviewsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/hotel.jpg")),
          ),
          Positioned(
            top: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/10,
                child: Scaffold(
                  appBar: TabBar(
                    labelColor: kdarkBlue,
                    labelStyle: TextStyle(
                        fontFamily: "nunito", fontWeight: FontWeight.bold),
                    controller: tabController,
                    indicatorColor: kdarkBlue,
                    tabs: <Widget>[
                      Tab(text: "OverView"),
                      //Tab(text: "Location"),
                      Tab(text: "Review"),
                    ],
                  ),
                  backgroundColor: kwhite,
                  body: Stack(
                    children: <Widget>[
                      TabBarView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BoldText(widget.shop.name, 20.0, kblack),
                                Row(
                                  children: <Widget>[
                                    BoldText("4.5 Stars", 12.0, korange),
                                    SizedBox(
                                      width: 16.0,
                                    ),
                                    Icon(
                                      Icons.location_on,
                                      color: kgreyDark,
                                      size: 15.0,
                                    ),
                                    NormalText(widget.shop.location, kgreyDark, 15.0),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                NormalText(
                                    "${widget.shop.price} \$ per night", kgreyDark, 16.0),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: 2,
                                  color: kgreyFill,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    BoldText("About this hotel", 20.0, kblack),
                                    BoldText("More", 16, kdarkBlue)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                NormalText(
                                    widget.shop.about,
                                    kblack,
                                    12.0),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: 2,
                                  color: kgreyFill,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    BoldText("equipments", 20.0, kblack),
                                    BoldText("More", 16, kdarkBlue),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    equipmentsItem(Icons.wifi, "Wi-Fi"),
                                    equipmentsItem(
                                        Icons.local_parking, "Parking"),
                                    equipmentsItem(Icons.pool, "Pool"),
                                    equipmentsItem(
                                        Icons.restaurant, "Restaurant"),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(16.0),
                          //   child: Container(
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: <Widget>[
                          //         BoldText("Location", 20.0, kblack),
                          //         ClipRRect(
                          //           borderRadius: BorderRadius.circular(20.0),
                          //           child: Image.asset(
                          //             "assets/plazamap.png",
                          //             fit: BoxFit.fill,
                          //             height:
                          //                 MediaQuery.of(context).size.width -
                          //                     90,
                          //             width: MediaQuery.of(context).size.width,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        BoldText("Reviews", 20.0, kblack),
                                        InkWell(
                                          child: BoldText("Add review", 16, korange),
                                          onTap: () {
                                            showMyInputDialog(context, "Add Review", "Set new name.", reviewController, () async {
                                              BackendMessage response = await customer.addHotelReview(widget.shop.id, reviewController.text);
                                              Navigator.of(context).pop();
                                              showMyDialog(context, response.status.toString(), response.status.toString() == 'success' ? 'Review added successfully' : response.message.toString() );
                                              setState(() {
                                                getReviewsData = customer.getHotelReviews(widget.shop.id);
                                              });
                                            });
                                          },
                                        )

                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 2/3,
                                        child: FutureBuilder(
                                          future: getReviewsData,
                                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                              case ConnectionState.waiting:
                                                return new Text('Loading...');
                                              default:
                                                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                                                else return createReviewsListView(context, snapshot);
                                            }
                                          },
                                        ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        controller: tabController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Positioned(
          //     top: 580,
          //     left: 5,
          //     child: WideButton(
          //       "BOOK NOW",
          //       () {},
          //     )),
        ],
      ),
    );
  }

  Widget createReviewsListView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic reviews = snapshot.data['message']['reviews'];
    int size = int.parse(snapshot.data['message']['size'].toString());
    // debugPrint('hotels:' + snapshot.data['message']['hotels'][0]['name'].toString());
    return new ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: size,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return reviewProfile(reviews[index]['user_name'].toString(), reviews[index]['review'].toString(), "05,Mar,2020");
      },
    );
  }

  Column equipmentsItem(IconData icon, String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Icon(
          icon,
          color: kdarkBlue,
        ),
        NormalText(text, kdarkBlue, 12)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    reviewController = new TextEditingController();
    scrollController = new ScrollController();
    customer = Customer();

    getReviewsData = customer.getHotelReviews(widget.shop.id);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    reviewController.dispose();
    scrollController.dispose();
  }
}
