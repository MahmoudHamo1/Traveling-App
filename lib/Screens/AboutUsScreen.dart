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

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  Customer customer = Customer();
  late TextEditingController nameController;
  late TextEditingController passwordController;


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
          title: NormalText("About Us", kblack, 20.0),
          backgroundColor: kwhite,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0,),
              Container(
                height: 2,
                color: kgreyFill,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child:  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Traveling around the world is become on of the most pleasures. With the huge technology improvement in the last century, people start to hear about beautiful nature views, historical places, fantastic cites and more.  But outside, there is uncountable number of places, you would be happier to visit some places more than others. So, you would better to know which place it’s the one for you in advance.'
                        ),
                        Text(
                          'To be a tourist and to have an opportunity to travel and discover the world, is such an amazing thing. However, there is many things you need to consider before start your journey. Usually, tourists travel to new countries where people have different traditions and may speak different languages, this makes the communication between tourists and local people a little bit hard. Also, tourist may get misleading information and start visiting places not their interests, here is where we come in.'
                        ),
                        Text(
                          'Our project aims to help tourists chose the right places by providing a description for each place. You hate reading? Don’t worry, our text-to-speech system will read the description for you. This will help you not to lose any view by reading while ride to your places. Also, translation system will be added to solve language barrier issue between tourists and local people.'
                        ),
                        Text(
                          'In addition to text-to-speech and translator systems, people can login to their accounts, react and comment about a specific place, post their journey experience in their timeline and other people can comment to posts. Moreover, users can share their journey with a live video chat so anybody can join their channel and join them virtually with their journey.'
                        )
                      ],
                    ),

                  ),
                ),
              )
            ],
          ),
        )
    );
  }

}

