import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:trawell/utils/Buttons.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';

import '../customer.dart';
import '../shop.dart';
import 'ChoseImageScreen.dart';
import 'ZegoLiveSteamPage.dart';

class HotelOverViewScreen extends StatefulWidget {
  final Shop shop;

  const HotelOverViewScreen({required Key key, required this.shop}) : super(key: key);
  @override
  _HotelOverViewScreenState createState() => _HotelOverViewScreenState();
}

class _HotelOverViewScreenState extends State<HotelOverViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late Customer customer;
  late TextEditingController reviewController;
  late ScrollController scrollController;
  late Future getReviewsData;
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

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

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.8);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true);
    setState(() {
      isPlaying = false;
    });
  }

  stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: InkWell(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: (widget.shop.imageUrl == '')
                      ? Image.asset("assets/hotel.jpg", fit: BoxFit.cover,)
                      : Image.network(widget.shop.imageUrl, fit: BoxFit.cover,),
              ),
              onTap: () {
              if (widget.shop.userId == customer.id) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ChoseImageScreen(id: widget.shop.id,
                      isForShop: true,
                      isForCity: false,
                      isForTimeline: false,
                      key: Key('imagePikkershop1'));
                }));
              }
              },
            )
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
                        controller: tabController,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BoldText(widget.shop.name, 20.0, kblack),
                                    InkWell(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(32.0),
                                      ),
                                      onTap: () async {
                                        var rating = await showRatingDialog(context, double.parse(widget.shop.averageLikes ?? '0.0'), widget.shop.id, 1 ); // 1: hotel, 2:city, 3:timeline
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.favorite_border,
                                        ),
                                      ),
                                    ),
                                    widget.shop.userId == customer.id
                                      ? InkWell(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(32.0),
                                        ),
                                        onTap: () async {
                                          Customer customer = Customer();
                                          BackendMessage response;
                                          bool isConfirmed = await showMyConfirmDialog(context);
                                          if (isConfirmed) {
                                            response = await customer.deleteHotel(widget.shop.id);
                                            await showMyDialog(context, response.status.toString(), response.message.toString());
                                            Navigator.of(context).pop();
                                          }

                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.delete,
                                          ),
                                        ),
                                    )
                                      : InkWell(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(32.0),
                                        ),
                                        onTap: () async {
                                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                                            return ZegoLiveStreamPage(isHost: false, userId: customer.id, userName: customer.name, liveId: widget.shop.userId, key: Key('ZegoLiveStreamPagehotel1'),);
                                          }));
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.live_tv_sharp,
                                          ),
                                        ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    BoldText(widget.shop.averageLikes != null ? widget.shop.averageLikes : "0", 12.0, korange),
                                    BoldText(" Stars", 12.0, korange),
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
                                const SizedBox(
                                  height: 10,
                                ),
                                NormalText(
                                    "${widget.shop.price} \$ per night", kgreyDark, 16.0),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: 2,
                                  color: kgreyFill,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    BoldText("About this hotel", 20.0, kblack),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(16),
                                                      bottomLeft: Radius.circular(16),
                                                      topRight: Radius.circular(0),
                                                      bottomRight: Radius.circular(0)),
                                                  side: BorderSide(color: Theme.of(context).primaryColor)
                                              )
                                          )
                                      ),
                                      onPressed: () {
                                        isPlaying ? stop() : speak(widget.shop.about);
                                        setState( () {
                                          isPlaying = !isPlaying;
                                        });
                                      },
                                      child: !isPlaying
                                          ? const Text(
                                          "🔊 Read out")
                                          : const Text(
                                          "🛑 Stop"),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                NormalText(
                                    widget.shop.about,
                                    kblack,
                                    12.0),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height: 2,
                                  color: kgreyFill,
                                ),
                                const SizedBox(
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
                                const SizedBox(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            right: 8,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () async {
                  var rating = await showRatingDialog(context, double.parse(widget.shop.averageLikes == null ? '0.0' : widget.shop.averageLikes), widget.shop.id, 1 ); // 1: hotel, 2:city, 3:timeline
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.favorite_border,
                  ),
                ),
              ),
            ),
          ),
          if (isPlaying)
            Positioned(
                top: 450,
                left: 50,
                child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Image.asset('assets/bot.png')
                )
            ),
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


}
