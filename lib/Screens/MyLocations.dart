import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lets_head_out/customer.dart';
import 'package:lets_head_out/utils/RecommendationImage.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';

import '../shop.dart';
import 'AddLocationScreen.dart';
import 'OverViewScreen.dart';

class MyLocations extends StatefulWidget {
  @override
  _MyLocationsState createState() => _MyLocationsState();
}

class _MyLocationsState extends State<MyLocations> with SingleTickerProviderStateMixin {
  TabController tabController;
  ScrollController scrollController;
  Customer customer;
  Future getHotelsData;
  @override
  Future<void> initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    scrollController = new ScrollController();
    customer = Customer();

    getHotelsData = customer.getCreatedHotels();

  }
  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    scrollController.dispose();
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
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            // Cities BarView
            Icon(Icons.person),
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
                            builder: (context) => AddLocationScreen(),
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
                      future: getHotelsData,
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
              return OverViewPage( shop: Shop(hotels[index]['id'], hotels[index]['name'], hotels[index]['price'], hotels[index]['location'], hotels[index]['about'], hotels[index]['user_id']),);
            }));
          },
        );
      },
    );
  }
}
