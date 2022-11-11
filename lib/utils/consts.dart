import 'package:flutter/material.dart';

final korange= const Color(0xFFFF9933);
final korangelite = const Color(0xFFFFBE83);
final kwhite = const Color(0xFFFFFFFF);
final kdarkBlue= const Color(0xFF333366);
final kblack = const Color(0xFF000000);
final kgreyDark =  Colors.grey.shade700;
final kgreyFill =  Colors.grey.shade100;


//Textss

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

 class NormalText extends StatelessWidget {
  final double  size;
  final String text;
  final Color color;

  NormalText(this.text,this.color, this.size);

  @override
  Widget build(BuildContext context) {
   return Text(text,style:TextStyle(fontFamily: "nunito" ,fontWeight:FontWeight.w300,color:color,fontSize: size));
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