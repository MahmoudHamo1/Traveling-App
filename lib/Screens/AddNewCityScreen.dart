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

class AddNewCityScreen extends StatefulWidget {
  @override
  _AddNewCityScreenState createState() => _AddNewCityScreenState();
}

class _AddNewCityScreenState extends State<AddNewCityScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: NormalText("Add New City", kblack, 20.0),
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
                  Container(width: 340.0, child: NormalForm(Icons.drive_file_rename_outline, "Name", nameController)),
                  SizedBox(
                    height: 30,
                  ),
                  Container(width: 340.0, child: NormalForm(Icons.location_on_rounded, "Location", locationController)),
                  SizedBox(
                    height: 30,
                  ),
                  Container(width: 340.0, child: NormalForm(Icons.abc_outlined, "About", aboutController)),
                  SizedBox(
                    height: 25,
                  ),
                  WideButton.bold("Add City", () async {
                    Customer customer = Customer();
                    BackendMessage response = await customer.addCity(nameController.text, locationController.text, aboutController.text, '');
                    if (response.status == 'success'){
                      await showMyDialog(context, 'Success', 'Added successfully');
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
