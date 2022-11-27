
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';

import '../city.dart';
import '../shop.dart';
import '../timeline.dart';
import 'CityOverViewScreen.dart';
import 'HotelOverViewScreen.dart';
import 'TimelineOverViewScreen.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  late ScrollController notificationsScrollController;

  @override
  void initState() {
    super.initState();
    notificationsScrollController = new ScrollController();
  }
  @override
  void dispose() {
    super.dispose();
    notificationsScrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
        appBar: AppBar(
        backgroundColor: kwhite,
        title: BoldText("My Notifications", 25, kblack),
    centerTitle: true,
    elevation: 0.0,
    ),
    body: SingleChildScrollView(
      child: createNotificationsListView(context),
    ));
  }

  Widget createNotificationsListView(BuildContext context) {
    return ListView.builder(
      controller: notificationsScrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: notificationsList.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 100,
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            BoldTextEllips(notificationsList[index].title, 20.0, kblack),
                            NormalTextEllips(notificationsList[index].body, kgreyDark,16),
                          ],
                        ),
                        onTap: () {
                          var payloadJson = jsonDecode(notificationsList[index].payload.toString());
                          if (payloadJson['newly_added'] == 'city') {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return CityOverViewScreen(
                                city: City(
                                  payloadJson['details']['id'],
                                  payloadJson['details']['name'],
                                  payloadJson['details']['location'],
                                  payloadJson['details']['about'],
                                  payloadJson['details']['user_id'],
                                  // notificationsList[index].payload['details']['average_like'],
                                  '0',
                                  payloadJson['details']['image_url']
                                ),
                                key: Key('cityFromNotifiaction'),
                              );
                            }));
                          } else if (payloadJson['newly_added'] == 'timeline') {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return TimelineOverViewScreen(
                                timeline: Timeline(
                                    payloadJson['details']['id'],
                                    payloadJson['details']['title'],
                                    payloadJson['details']['body'],
                                    payloadJson['details']['user_id'],
                                    '0',
                                    payloadJson['details']['image_url']
                                ),
                                key: Key('timelineFromNotifiaction'),
                              );
                            }));
                          } else if (payloadJson['newly_added'] == 'hotel') {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return HotelOverViewScreen(
                                shop: Shop(
                                    payloadJson['details']['id'],
                                    payloadJson['details']['name'],
                                    payloadJson['details']['price'],
                                    payloadJson['details']['location'],
                                    payloadJson['details']['about'],
                                    payloadJson['details']['user_id'],
                                    payloadJson['details']['average_like'],
                                    payloadJson['details']['image_url']
                                ),
                                key: Key('hotelFromNotifiaction'),);
                            }));
                          }
                        },
                      ),
                    ),
                    InkWell(
                      child: Icon(Icons.delete,size: 20.0,color: kblack,),
                      onTap: () {
                        setState(() {
                          notificationsList.remove(notificationsList[index]);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}
