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

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: NormalText("Register", kblack, 20.0),
          backgroundColor: kwhite,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: <Widget>[
          Icon(
            FontAwesomeIcons.plane,
            color: kdarkBlue,
            size: 35,
          ),
          SizedBox(height: 10),
          BoldText("Aight", 30.0, kdarkBlue),
          NormalText("Let's Head Out", kdarkBlue, 30.0),
          SizedBox(
            height: 20,
          ),
          Container(width: 340.0, child: NormalForm(Icons.person, "Full name", nameController)),
          SizedBox(
            height: 30,
          ),
          Container(width: 340.0, child: NormalForm(Icons.email, "Email", emailController)),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 340.0,
            child: PasswordForm(passwordController),
          ),
                  SizedBox(
                    height: 30,
                  ),
                  WideButton.bold("Register",  () async {
                    Customer customer = Customer();
                    BackendMessage response = await customer.signupToBackend(nameController.text, emailController.text, passwordController.text);
                    if (response.status == 'success'){
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return Home();
                      }));
                    } else {
                      showMyDialog(context, 'Error', response.message);
                    }
                  }, true),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 2,
                        width: 100,
                        color: kdarkBlue,
                      ),
                      NormalText("Or Sign in with", kdarkBlue, 12.5),
                      Container(
                        height: 2,
                        width: 100,
                        color: kdarkBlue,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    FontAwesomeIcons.facebookSquare,
                    color: Colors.blue.shade600,
                    size: 40.0,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      NormalText("Have an account ?", kdarkBlue, 12.5),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(CupertinoPageRoute<bool>(
                            fullscreenDialog: true,
                            builder: (context) => SignInPage(),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.0,),
                          child: BoldText.veryBold("Sign In ?", 12.5, korange,true),
                        ),
                      ),
                    ],
                  ),
        ]))));
  }
}
