import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trawell/Screens/AddNewCityScreen.dart';
import 'package:trawell/Screens/TimelineOverViewScreen.dart';
import 'package:trawell/customer.dart';
import 'package:trawell/utils/RecommendationImage.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';
import 'package:trawell/timeline.dart';

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
  late TabController tabController;
  late ScrollController hotelsScrollController;
  late ScrollController citiesScrollController;
  late ScrollController timelinesScrollController;
  late Customer customer;
  late Future getUserHotelsDataFuture;
  late Future getUserCitiesDataFuture;
  late Future getUserTimelinesDataFuture;

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
          tabs: const <Widget>[
            Tab(text: "Cities"),
            Tab(text: "Hotels"),
            Tab(text: "Timelines"),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            // Cities BarView
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
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
              child: ListView(
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
              child: ListView(
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
        ),
      ),
    );
  }


  Widget createHotelsListView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic hotels = snapshot.data['message']['hotels'];
    int size = int.parse(snapshot.data['message']['size'].toString());
    // debugPrint('hotels:' + snapshot.data['message']['hotels'][0]['name'].toString());
    return ListView.builder(
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: (hotels[index]['image_url'].toString() == '')
                          ? Image.asset("assets/sheraton.jpg", fit: BoxFit.cover,)
                          : Image.network(hotels[index]['image_url'].toString(), fit: BoxFit.cover,),
                  ),
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
              return HotelOverViewScreen( shop: Shop(hotels[index]['id'], hotels[index]['name'], hotels[index]['price'], hotels[index]['location'], hotels[index]['about'], hotels[index]['user_id'], hotels[index]['average_like'], hotels[index]['image_url']), key: Key('null'),);
            }));
          },
        );
      },
    );
  }
  Widget createCitiesListView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic cities = snapshot.data['message']['cities'];
    int size = int.parse(snapshot.data['message']['size'].toString());

    return ListView.builder(
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: (cities[index]['image_url'].toString() == '')
                          ? Image.asset("assets/sheraton.jpg", fit: BoxFit.cover,)
                          : Image.network(cities[index]['image_url'].toString(), fit: BoxFit.cover,),
                  ),
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
              return CityOverViewScreen( city: City(cities[index]['id'], cities[index]['name'], cities[index]['location'], cities[index]['about'], cities[index]['user_id'], cities[index]['average_like'], cities[index]['image_url']), key: Key('null'),);
            }));
          },
        );
      },
    );
  }
  Widget createTimelinesListView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic timelines = snapshot.data['message']['timelines'];
    int size = int.parse(snapshot.data['message']['size'].toString());

    return ListView.builder(
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
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: (timelines[index]['image_url'].toString() == '')
                          ? Image.asset("assets/sheraton.jpg", fit: BoxFit.cover,)
                          : Image.network(timelines[index]['image_url'].toString(), fit: BoxFit.cover,),
                  ),
                ),
                NormalText(timelines[index]['body'].toString(), kgreyDark, 12.0),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return TimelineOverViewScreen( timeline: Timeline(timelines[index]['id'], timelines[index]['title'], timelines[index]['body'], timelines[index]['user_id'], timelines[index]['average_like'], timelines[index]['image_url']), key: Key('null'),);
            }));
          },
        );
      },
    );
  }
}
