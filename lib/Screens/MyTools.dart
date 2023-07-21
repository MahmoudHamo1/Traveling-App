import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trawell/Screens/AddNewCityScreen.dart';
import 'package:trawell/Screens/LiveBroadcastScreen.dart';
import 'package:trawell/Screens/TimelineOverViewScreen.dart';
import 'package:trawell/Screens/speakNative.dart';
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
import 'TextToSpeakScreen.dart';

class MyTools extends StatefulWidget {
  @override
  _MyToolsState createState() => _MyToolsState();
}

class _MyToolsState extends State<MyTools> with SingleTickerProviderStateMixin {
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
        title: BoldText("My Tools", 25, kblack),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Scaffold(
        backgroundColor: kwhite,
        appBar: TabBar(
          labelColor: kdarkBlue,
          labelStyle:
              const TextStyle(fontFamily: "nunito", fontWeight: FontWeight.bold),
          controller: tabController,
          indicatorColor: kdarkBlue,
          tabs: const <Widget>[
            Tab(text: "Translator"),
            Tab(text: "Speak Bot"),
            Tab(text: "Go Online"),
          ],
        ),
        body: TabBarView(
          controller: tabController,
          children: const <Widget>[
            // SpeakNative BarView
            SpeakNative(key: Key('null'),),
            // TextToSpeakScreen BarView
            TextToSpeakScreen(key: Key('null1'),),
            // Go online BarView
            LiveBroadcastScreen(key: Key('liveBroadcast'))
          ],
        ),
      ),
    );
  }

}
