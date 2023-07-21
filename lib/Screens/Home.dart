import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trawell/Screens/DashBoard.dart';
import 'package:trawell/customer.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';

import '../main.dart';
import 'MyTools.dart';
import 'Notifications.dart';
import 'MyLocations.dart';
import 'Profile.dart';
import 'SignInPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _cIndex = 0;

  late PageController _pageController;



  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    setupFirebaseMessaging();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
          selectedIndex: _cIndex,
          showElevation: true,
          backgroundColor: kwhite,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              activeColor: kdarkBlue,
              inactiveColor: kgreyDark,
              title: Text(
                "Home",
                style: TextStyle(fontFamily: "nunito"),
              ),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.line_style),
              title: Text(
                "Locations",
                style: TextStyle(fontFamily: "nunito"),
              ),
              inactiveColor: kgreyDark,
              activeColor: kdarkBlue,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.construction),
              title: Text(
                "Tools",
                style: TextStyle(fontFamily: "nunito"),
              ),
              inactiveColor: kgreyDark,
              activeColor: kdarkBlue,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.notifications),
              title: Text(
                "Notifications",
                style: TextStyle(fontFamily: "nunito"),
              ),
              inactiveColor: kgreyDark,
              activeColor: kdarkBlue,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text(
                "Profile",
                style: TextStyle(fontFamily: "nunito"),
              ),
              inactiveColor: kgreyDark,
              activeColor: kdarkBlue,
            )
          ],
          onItemSelected: (index) {
            _incrementTab(index);
          }),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _cIndex = index);
          },
          children: <Widget>[
            Dashboard(),
            MyLocations(),
            MyTools(),
            Notifications(),
            Profile(),
          ],
        ),
      ),
    );
  }


  void setupFirebaseMessaging() async {

    await FirebaseMessaging.instance.subscribeToTopic('allUsers');

    // this code used when you want to show/do something when notification comes while the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      dynamic payload = message.data ;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        debugPrint('receive front message');
        debugPrint('notification.title: ${notification?.title}');
        debugPrint('notification.body: ${notification?.body}');
        debugPrint('notification.payload: ${payload['payload']}');
        setState(() {
          notificationsList.add(NotificationMessage(notification.title!, notification.body!, payload['payload']));
        });
      }
    });
  }
}
