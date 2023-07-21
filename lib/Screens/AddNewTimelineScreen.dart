import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trawell/Screens/SignInPage.dart';
import 'package:trawell/utils/Buttons.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';
import 'package:trawell/utils/forms.dart';
import 'package:trawell/customer.dart';
import 'package:trawell/Screens/Home.dart';

class AddNewTimelineScreen extends StatefulWidget {
  @override
  _AddNewTimelineScreenState createState() => _AddNewTimelineScreenState();
}

class _AddNewTimelineScreenState extends State<AddNewTimelineScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: NormalText("Add New Timeline", kblack, 20.0),
          backgroundColor: kwhite,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Container(width: 340.0, child: NormalForm(Icons.title, "title", titleController)),
                  SizedBox(
                    height: 30,
                  ),
                  Container(width: 340.0, child: NormalForm(Icons.notes_sharp, "body", bodyController)),
                  SizedBox(
                    height: 25,
                  ),
                  WideButton.bold("Add Timeline", () async {
                    Customer customer = Customer();
                    BackendMessage response = await customer.addTimeline(titleController.text, bodyController.text, '');
                    if (response.status == 'success'){
                      await showMyDialog(context, 'Success', response.message);
                    } else {
                      await showMyDialog(context, 'Error', response.message);
                    }
                    Navigator.pop(context,);
                  }, true),
                ])
            )
        )
    );
  }
}
