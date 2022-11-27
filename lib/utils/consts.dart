import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../customer.dart';

final korange= const Color(0xFFFF9933);
final korangelite = const Color(0xFFFFBE83);
final kwhite = const Color(0xFFFFFFFF);
final kdarkBlue= const Color(0xFF333366);
final kblack = const Color(0xFF000000);
final kgreyDark =  Colors.grey.shade700;
final kgreyFill =  Colors.grey.shade100;

//Shared Variables
List<NotificationMessage> notificationsList = <NotificationMessage>[];
//Texts

 const String POPPINS = "Poppins";
 const String OPEN_SANS = "OpenSans";
 const String SKIP = "Skip";
 const String NEXT = "Next";
 const String SLIDER_HEADING_1 = "Fast Travel!";
 const String SLIDER_HEADING_2 = "Easy to Use!";
 const String SLIDER_HEADING_3 = "Safest Option";
 const String SLIDER_DESC = "Live the best and easiest traveling experience with us,the fastest and most reliable option you can ever find.";

 Future<void> showMyDialog(BuildContext context, String title, String body) async {
  return showDialog<void>(
   context: context,
   barrierDismissible: false, // user must tap button!
   builder: (BuildContext context) {
    return AlertDialog(
     title: Text(title),
     content: SingleChildScrollView(
      child: ListBody(
       children: <Widget>[
        Text(body),
       ],
      ),
     ),
     actions: <Widget>[
      TextButton(
       child: const Text('Cancel'),
       onPressed: () {
        Navigator.of(context).pop();
       },
      ),
     ],
    );
   },
  );
 }
 Future<bool> showMyConfirmDialog(BuildContext context) async {
  bool isConfirmed = false;
   await showDialog<void>(
     context: context,
     barrierDismissible: false, // user must tap button!
     builder: (BuildContext context) {
      return AlertDialog(
       title: const Text("Are you sure you want to delete ?"),
       actions: <Widget>[
        TextButton(
         child: const Text('Confirm'),
         onPressed: () {
          isConfirmed = true;
          Navigator.of(context).pop();
         },
        ),
        TextButton(
         child: const Text('Cancel'),
         onPressed: () {
          isConfirmed = false;
          Navigator.of(context).pop();
         },
        ),
       ],
     );
    },
   );
   return isConfirmed;
 }

 Future<double> showRatingDialog(BuildContext context, double rateValue, String id,int ratedLocation) async {
  double rate = rateValue == null ? 0 : rateValue ;
  await showDialog(
   context: context,
   builder: (context) {
    return AlertDialog(
     // Retrieve the text the user has entered by using the
     // TextEditingController.
     content: SmoothStarRating(
      allowHalfRating: true,
      starCount: 5,
      rating: rate,
      size: 50,
      onRated: (rating) => {
       rate =  rating.toDouble()
      },
     ),
     actions: <Widget>[
      // usually buttons at the bottom of the dialog
      TextButton(
       child: new Text("Ok"),
       onPressed: () async {
         Customer customer = Customer();
         BackendMessage response;
         // rate an hotel
         if (ratedLocation == 1 ) {
           response = await customer.addHotelLike(id, rate);
           Navigator.of(context).pop();
           showMyDialog(context, response.status.toString(), response.message.toString());
         }
         // rate city
         else if (ratedLocation == 2) {
           response = await customer.addCityLike(id, rate);
           Navigator.of(context).pop();
           showMyDialog(context, response.status.toString(), response.message.toString());
         }
         // rate timeline
         else if (ratedLocation == 3) {
          response = await customer.addTimelineLike(id, rate);
          Navigator.of(context).pop();
          showMyDialog(context, response.status.toString(), response.message.toString());
         }
       }
      ),
     ],
    );
   },
  );
  return rate;
 }

 Future<void> showMyInputDialog(BuildContext context, String title, String body, TextEditingController _textFieldController, _onSet) async {
   return showDialog<void>(
     context: context,
     barrierDismissible: false, // user must tap button!
     builder: (BuildContext context) {
      return AlertDialog(
       title: Text(title),
       content: TextField(
        onChanged: (value) { },
        controller: _textFieldController,
        decoration: InputDecoration(hintText: "Text Field in Dialog"),
       ),
       actions: <Widget>[
        TextButton(
         child: const Text('Cancel'),
         onPressed: () {
          Navigator.of(context).pop();
         },
        ),
        TextButton(
         child: const Text('Update'),
         onPressed: _onSet,
        ),
       ],
      );
     },
   );
 }

 Widget InformationItem(String title, String body, _onTap) {
  return InkWell(
   onTap: _onTap,
   child: Padding(
    padding: const EdgeInsets.only(left: 16,right: 16,bottom: 9),
    child: Row(
     children: <Widget>[
      NormalText(title,kblack,25.0),
      SizedBox(width: 8,),
      NormalText(body,kblack,20.0)
     ],
    ),
   ),
  );
 }

 class BoldText extends StatelessWidget {
  final double  size;
  final String text;
  final Color color;
  bool isVeryBold=false;

  BoldText(this.text, this.size,this.color);
  BoldText.veryBold(this.text,this.size,this.color,this.isVeryBold);

  @override
  Widget build(BuildContext context) {
   return Text(text,style:TextStyle(fontFamily: "nunito" ,fontWeight: isVeryBold?FontWeight.w900: FontWeight.w700,color:color,fontSize: size));
  }
 }

 class BoldTextEllips extends StatelessWidget {
  final double  size;
  final String text;
  final Color color;
  bool isVeryBold=false;

  BoldTextEllips(this.text, this.size,this.color);
  BoldTextEllips.veryBold(this.text,this.size,this.color,this.isVeryBold);

  @override
  Widget build(BuildContext context) {
   return Text(text,style:TextStyle(fontFamily: "nunito" ,fontWeight: isVeryBold?FontWeight.w900: FontWeight.w700,color:color,fontSize: size, overflow: TextOverflow.ellipsis,));
  }
 }

 class NormalText extends StatelessWidget {
  final double  size;
  final String text;
  final Color color;

  NormalText(this.text,this.color, this.size);

  @override
  Widget build(BuildContext context) {
   return Text(text,style:TextStyle(fontFamily: "nunito" ,fontWeight:FontWeight.w300,color:color,fontSize: size,));
  }
 }

 class NormalTextEllips extends StatelessWidget {
  final double  size;
  final String text;
  final Color color;

  NormalTextEllips(this.text,this.color, this.size);

  @override
  Widget build(BuildContext context) {
   return Text(text,style:TextStyle(fontFamily: "nunito" ,fontWeight:FontWeight.w300,color:color,fontSize: size, overflow: TextOverflow.ellipsis,));
  }
 }

 Widget reviewProfile(String name,String review,String date) {
 return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[

   Row(
    children: <Widget>[
     Container(
      width: 24,
      height: 24,
      child: CircleAvatar(
       backgroundColor: kgreyDark,
       child: Icon(
        Icons.person,
        size: 12,
       ),
      ),
     ),
     SizedBox(
      width: 10,
     ),
     BoldText(name, 16, kblack)
    ],
   ),
   SizedBox(height: 10,),
   // Row(
   //   children: <Widget>[
   //     Container(
   //       width: 50.0,
   //       decoration: BoxDecoration(
   //         color: korange,
   //         borderRadius:
   //         BorderRadius.circular(10.0),
   //       ),
   //       child: Row(
   //         mainAxisAlignment:
   //         MainAxisAlignment.center,
   //         crossAxisAlignment:
   //         CrossAxisAlignment.center,
   //         children: <Widget>[
   //           Icon(
   //             Icons.star,
   //             color: kwhite,
   //             size: 15.0,
   //           ),
   //           BoldText(review, 15.0, kwhite),
   //         ],
   //       ),
   //     ),
   //     SizedBox(width: 10,),
   //     NormalText(date,kgreyDark,12.0)
   //   ],
   //
   // ),
   // SizedBox(height: 10,),
   NormalText(review ,kblack,12.0),
   SizedBox(height: 10,),
  ],
 );
}

