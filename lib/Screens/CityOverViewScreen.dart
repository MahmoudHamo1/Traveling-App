import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:trawell/utils/Buttons.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';
import '../city.dart';
import '../customer.dart';
import 'ChoseImageScreen.dart';
import 'ZegoLiveSteamPage.dart';

class CityOverViewScreen extends StatefulWidget {
  final City city;

  const CityOverViewScreen({required Key key, required this.city}) : super(key: key);
  @override
  _CityOverViewScreenState createState() => _CityOverViewScreenState();
}

class _CityOverViewScreenState extends State<CityOverViewScreen>
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

    getReviewsData = customer.getCityReviews(widget.city.id);

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
                child: (widget.city.imageUrl == '')
                    ? Image.asset("assets/alger.jpg", fit: BoxFit.cover,)
                    : Image.network(widget.city.imageUrl, fit: BoxFit.cover,),
              ),
              onTap: () {
                if (widget.city.userId == customer.id) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ChoseImageScreen(id: widget.city.id,
                        isForShop: false,
                        isForCity: true,
                        isForTimeline: false,
                        key: Key('imagePikkercty1'));
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
                    labelStyle: const TextStyle(
                        fontFamily: "nunito", fontWeight: FontWeight.bold),
                    controller: tabController,
                    indicatorColor: kdarkBlue,
                    tabs: const <Widget>[
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
                          // main view bar
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BoldText(widget.city.name, 20.0, kblack),
                                    InkWell(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(32.0),
                                      ),
                                      onTap: () async {
                                        var rating = await showRatingDialog(context, double.parse(widget.city.averageLikes ?? '0.0'), widget.city.id, 2 ); // 1: hotel, 2:city, 3:timeline
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.favorite_border,
                                        ),
                                      ),
                                    ),
                                    widget.city.userId == customer.id
                                      ? InkWell(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(32.0),
                                      ),
                                      onTap: () async {
                                        Customer customer = Customer();
                                        BackendMessage response;
                                        bool isConfirmed = await showMyConfirmDialog(context);
                                        if (isConfirmed) {
                                          response = await customer.deleteCity(widget.city.id);
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
                                          return ZegoLiveStreamPage(isHost: false, userId: customer.id, userName: customer.name, liveId: widget.city.userId, key: Key('ZegoLiveStreamPagecity1'),);
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
                                    BoldText(widget.city.averageLikes != null ? widget.city.averageLikes : "0", 12.0, korange),
                                    BoldText(" Stars", 12.0, korange),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Icon(
                                      Icons.location_on,
                                      color: kgreyDark,
                                      size: 15.0,
                                    ),
                                    NormalText(widget.city.location, kgreyDark, 15.0),
                                  ],
                                ),
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
                                    BoldText("About this city", 20.0, kblack),
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
                                        isPlaying ? stop() : speak(widget.city.about);
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
                                    widget.city.about,
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

                              ],
                            ),
                          ),
                          // reviews bar
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
                                              BackendMessage response = await customer.addCityReview(widget.city.id, reviewController.text);
                                              Navigator.of(context).pop();
                                              showMyDialog(context, response.status.toString(), response.status.toString() == 'success' ? 'Review added successfully' : response.message.toString() );
                                              setState(() {
                                                getReviewsData = customer.getCityReviews(widget.city.id);
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
