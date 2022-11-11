import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/Screens/AddNewCityScreen.dart';
import 'package:lets_head_out/Screens/TimelineReviewsScreen.dart';
import 'package:lets_head_out/customer.dart';
import 'package:lets_head_out/utils/RecommendationImage.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';
import 'package:lets_head_out/timeline.dart';

import '../city.dart';
import '../shop.dart';
import 'AddNewHotelScreen.dart';
import 'AddNewTimelineScreen.dart';
import 'CityOverViewScreen.dart';
import 'HotelOverViewScreen.dart';

class MyLocations extends StatefulWidget {
  @override
  _MyLocationsState createState() => _MyLocationsState();
}

class _MyLocationsState extends State<MyLocations> with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController hotelsScrollController;
  ScrollController citiesScrollController;
  ScrollController timelinesScrollController;
  Customer customer;
  Future getUserHotelsDataFuture;
  Future getUserCitiesDataFuture;
  Future getUserTimelinesDataFuture;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
    hotelsScrollController = new ScrollController();
    citiesScrollController = new ScrollController();
    timelinesScrollController = new ScrollController();
    customer = Customer();

    getUserHotelsDataFuture = customer.getCreatedHotels();
    getUserCitiesDataFuture = customer.getCreatedCities();
    getUserTimelinesDataFuture = customer.getCreatedTimelines();

  }
  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    hotelsScrollController.dispose();
    citiesScrollController.dispose();
    timelinesScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kwhite,
        title: BoldText("My Locations", 25, kblack),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: TabBar(
          labelColor: kdarkBlue,
          labelStyle:
              TextStyle(fontFamily: "nunito", fontWeight: FontWeight.bold),
          controller: tabController,
          indicatorColor: kdarkBlue,
          tabs: <Widget>[
            Tab(text: "Cities"),
            Tab(text: "Hotels"),
            Tab(text: "Timelines"),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            // Cities BarView
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BoldText("Current Cities", 20.0, kblack),
                      InkWell (
                        child: BoldText("Add", 16, korange),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute<bool>(
                            fullscreenDialog: true,
                            builder: (context) => AddNewCityScreen(),
                          ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Container(
                      width: MediaQuery.of(context).size.width-80,
                      height: MediaQuery.of(context).size.height-300,
                      child: FutureBuilder(
                        future: getUserCitiesDataFuture,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return new Text('Loading...');
                            default:
                              if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                              else return createCitiesListView(context, snapshot);
                          }
                        },

                      )
                  ),
                ],
              ),
            ),
            // Hotels BarView
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BoldText("Current Hotels", 20.0, kblack),
                      InkWell (
                        child: BoldText("Add", 16, korange),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute<bool>(
                            fullscreenDialog: true,
                            builder: (context) => AddNewHotelScreen(),
                          ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Container(
                    width: MediaQuery.of(context).size.width-80,
                    height: MediaQuery.of(context).size.height-300,
                    child: FutureBuilder(
                      future: getUserHotelsDataFuture,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                            else return createHotelsListView(context, snapshot);
                        }
                      },

                    )
                  ),
                ],
              ),
            ),
            // Timelines BarView
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BoldText("Current Timelines", 20.0, kblack),
                      InkWell (
                        child: BoldText("Add", 16, korange),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute<bool>(
                            fullscreenDialog: true,
                            builder: (context) => AddNewTimelineScreen(),
                          ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Container(
                      width: MediaQuery.of(context).size.width-80,
                      height: MediaQuery.of(context).size.height-300,
                      child: FutureBuilder(
                        future: getUserTimelinesDataFuture,
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return new Text('Loading...');
                            default:
                              if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                              else return createTimelinesListView(context, snapshot);
                          }
                        },

                      )
                  ),
                ],
              ),
            ),
          ],
          controller: tabController,
        ),
      ),
    );
  }


  Widget createHotelsListView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic hotels = snapshot.data['message']['hotels'];
    int size = int.parse(snapshot.data['message']['size'].toString());
    // debugPrint('hotels:' + snapshot.data['message']['hotels'][0]['name'].toString());
    return new ListView.builder(
      controller: hotelsScrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: size,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width-80,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width:MediaQuery.of(context).size.width-80,
                  height: 200.0,
                  child: ClipRRect(
                      borderRadius: new BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.asset(
                        "assets/sheraton.jpg",
                        fit: BoxFit.fitHeight,
                      )),
                ),
                BoldText(hotels[index]['name'].toString(), 20.0, kblack),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NormalText(hotels[index]['location'].toString(), kgreyDark, 12.0),
                    Icon(
                      Icons.location_on,
                      color: kgreyDark,
                      size: 16.0,
                    )
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return HotelOverViewScreen( shop: Shop(hotels[index]['id'], hotels[index]['name'], hotels[index]['price'], hotels[index]['location'], hotels[index]['about'], hotels[index]['user_id']),);
            }));
          },
        );
      },
    );
  }
  Widget createCitiesListView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic cities = snapshot.data['message']['cities'];
    int size = int.parse(snapshot.data['message']['size'].toString());

    return new ListView.builder(
      controller: citiesScrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: size,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width-80,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width:MediaQuery.of(context).size.width-80,
                  height: 200.0,
                  child: ClipRRect(
                      borderRadius: new BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.asset(
                        "assets/sheraton.jpg",
                        fit: BoxFit.fitHeight,
                      )),
                ),
                BoldText(cities[index]['name'].toString(), 20.0, kblack),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NormalText(cities[index]['location'].toString(), kgreyDark, 12.0),
                    Icon(
                      Icons.location_on,
                      color: kgreyDark,
                      size: 16.0,
                    )
                  ],
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return CityOverViewScreen( city: new City(cities[index]['id'], cities[index]['name'], cities[index]['location'], cities[index]['about'], cities[index]['user_id']),);
            }));
          },
        );
      },
    );
  }
  Widget createTimelinesListView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic timelines = snapshot.data['message']['timelines'];
    int size = int.parse(snapshot.data['message']['size'].toString());

    return new ListView.builder(
      controller: citiesScrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: size,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width-80,
            // height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BoldText(timelines[index]['title'].toString(), 20.0, kblack),
                Container(
                  width:MediaQuery.of(context).size.width-80,
                  height: 200.0,
                  child: ClipRRect(
                      borderRadius: new BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: Image.asset(
                        "assets/sheraton.jpg",
                        fit: BoxFit.fitHeight,
                      )),
                ),
                NormalText(timelines[index]['body'].toString(), kgreyDark, 12.0),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return TimelineReviewsScreen( timeline: new Timeline(timelines[index]['id'], timelines[index]['title'], timelines[index]['body'], timelines[index]['user_id']),);
            }));
          },
        );
      },
    );
  }
}
