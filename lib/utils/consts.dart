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

