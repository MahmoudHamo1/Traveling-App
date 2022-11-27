import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trawell/Screens/MyInformationScreen.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';

import '../customer.dart';
import 'AboutUsScreen.dart';
import 'ChoseImageScreen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Customer customer = Customer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar(
        backgroundColor: kwhite,
        title: BoldText("Profile", 25, kblack),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    child: (customer.imageUrl == '')
                      ? CircleAvatar(
                            backgroundColor: kgreyDark,
                            radius: 50,
                            child:  const Icon(Icons.person,size: 50,)
                        )
                      : CircleAvatar(
                            backgroundColor: kgreyDark,
                            radius: 50,
                            backgroundImage: NetworkImage(customer.imageUrl)
                        ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return ChoseImageScreen(id: customer.id, isForShop: false, isForCity: false, isForTimeline: false, key: Key('imagePikkeruser1'));
                      }));
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      BoldText(customer.name, 20.0, kblack),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              height: 2,
              color: kgreyFill,
            ),
            ProfileItem(Icons.person,"My Informations", (){
              Navigator.of(context, rootNavigator: true)
                  .push(CupertinoPageRoute<bool>(
                fullscreenDialog: true,
                builder: (context) => MyInformationScreen(),
              ));
            }),
            // ProfileItem(Icons.credit_card,"Payment", (){}),
            // ProfileItem(Icons.settings,"Settings", (){}),
            // ProfileItem(Icons.help,"Help", (){}),
            // ProfileItem(Icons.favorite_border,"Favourite", (){}),
            // ProfileItem(Icons.library_books,"Terms and Conditions", (){}),
            ProfileItem(Icons.info,"About Us ", (){
              Navigator.of(context, rootNavigator: true)
                  .push(CupertinoPageRoute<bool>(
                fullscreenDialog: true,
                builder: (context) => AboutUsScreen(),
              ));
            }),
            ProfileItem(Icons.exit_to_app,"Sign Out", (){
              Navigator.of(context).pop();
            }),


          ],
        ),
      ),
    );
  }

  Widget ProfileItem(IconData icon, String text, _onTab) {
    return InkWell(
      onTap: _onTab,
      child: Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 9),
        child: Row(
          children: <Widget>[
            Icon(icon, color: kdarkBlue,size: 40,),
            SizedBox(width: 8,),
            NormalText(text,kblack,20.0)
          ],
        ),
      ),
    );
  }
}
