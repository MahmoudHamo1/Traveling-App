import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lets_head_out/Screens/SignInPage.dart';
import 'package:lets_head_out/utils/Buttons.dart';
import 'package:lets_head_out/utils/TextStyles.dart';
import 'package:lets_head_out/utils/consts.dart';
import 'package:lets_head_out/utils/forms.dart';
import 'package:lets_head_out/customer.dart';
import 'package:lets_head_out/Screens/Home.dart';

class MyInformationScreen extends StatefulWidget {
  @override
  _MyInformationScreenState createState() => _MyInformationScreenState();
}

class _MyInformationScreenState extends State<MyInformationScreen> {
  Customer customer = Customer();
  TextEditingController nameController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: NormalText("My Information", kblack, 20.0),
          backgroundColor: kwhite,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
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
                    CircleAvatar(
                      backgroundColor: kgreyDark,
                      radius: 50,
                      child: Icon(Icons.person,size: 50,),
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
              InformationItem("Name", customer.name, () {
                showMyInputDialog(context, "Update Name", "Set new name.", nameController, () async {
                  BackendMessage response = await customer.updateName(nameController.text);
                  Navigator.of(context).pop();
                  showMyDialog(context, response.status.toString(), response.message.toString());
                  if (response.status == 'success') setState(() { customer.name = nameController.text; });
                });
              }),
              InformationItem("Email", customer.email, (){} ),
              InformationItem("Password",customer.password, (){
                showMyInputDialog(context, "Update password", "Set new password.", passwordController, () async {
                  BackendMessage response = await customer.updatePassword(passwordController.text);
                  Navigator.of(context).pop();
                  showMyDialog(context, response.status.toString(), response.message.toString());
                  if (response.status == 'success') setState(() { customer.password = passwordController.text; });
                });
              }),
            ],
          ),
        )
    );
  }

  Widget ProfileItem(IconData icon, String text, _onTap) {
    return InkWell(
      onTap: _onTap,
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
}

