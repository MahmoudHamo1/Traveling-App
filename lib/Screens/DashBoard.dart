import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trawell/utils/BestRatedImage.dart';
import 'package:trawell/utils/Buttons.dart';
import 'package:trawell/utils/CitiesImage.dart';
import 'package:trawell/utils/RecommendationImage.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';
import 'package:trawell/utils/imageContainer.dart';

import '../city.dart';
import '../customer.dart';
import '../shop.dart';
import '../timeline.dart';
import 'CityOverViewScreen.dart';
import 'HotelOverViewScreen.dart';
import 'TimelineOverViewScreen.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late ScrollController hotelsScrollController;
  late ScrollController citiesScrollController;
  late ScrollController timelinesScrollController;
  late Customer customer;
  late Future getAllHotelsFuture;
  late Future getAllCitiesFuture;
  late Future getAllTimelinesFuture;

  @override
  void initState() {
    super.initState();
    hotelsScrollController = new ScrollController();
    citiesScrollController = new ScrollController();
    timelinesScrollController = new ScrollController();
    customer = Customer();

    getAllHotelsFuture = customer.getAllHotels();
    getAllCitiesFuture = customer.getAllCities();
    getAllTimelinesFuture = customer.getAllTimelines();

  }
  @override
  void dispose() {
    super.dispose();
    hotelsScrollController.dispose();
    citiesScrollController.dispose();
    timelinesScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ImageContainer(),

            Padding(
              padding: const EdgeInsets.only(left:16.0,right: 16.0,bottom: 16.0),

              child: Column(children: <Widget>[
                // Hotels
                Padding(
                  padding: const EdgeInsets.only( top: 10,bottom: 16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: BoldText("Hotels", 20.0, kblack)),
                ),
                Container(
                    width: 400,
                    height: 250,
                    child: FutureBuilder(
                      future: getAllHotelsFuture,
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
                // Cities
                Padding(
                  padding: const EdgeInsets.only( top: 10,bottom: 16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: BoldText("Cities", 20.0, kblack)),
                ),
                Container(
                    width: 400,
                    height: 250,
                    child: FutureBuilder(
                      future: getAllCitiesFuture,
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
                // Timelines
                Padding(
                  padding: const EdgeInsets.only( top: 10,bottom: 16.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: BoldText("Timelines", 20.0, kblack)),
                ),
                Container(
                    width: 400,
                    height: 250,
                    child: FutureBuilder(
                      future: getAllTimelinesFuture,
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

              ]),
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
        left: 5,
        right:5,
      ),
      itemCount: size,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: BestRatedImage(hotels[index]['image_url'], hotels[index]['name'], hotels[index]['location'], hotels[index]['average_like']),
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
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      itemCount: size,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: BestRatedImage(cities[index]['image_url'], cities[index]['name'], cities[index]['location'], cities[index]['average_like'],),
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
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
      ),
      itemCount: size,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: BestRatedImage(timelines[index]['image_url'], timelines[index]['title'], timelines[index]['body'], timelines[index]['average_like']),
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
