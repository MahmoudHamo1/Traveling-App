import 'dart:developer';

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
import 'package:lets_head_out/timeline.dart';
class TimelineReviewsScreen extends StatefulWidget {
  final Timeline timeline;

  const TimelineReviewsScreen({Key key, this.timeline}) : super(key: key);
  @override
  _TimelineReviewsScreenState createState() => _TimelineReviewsScreenState();
}

class _TimelineReviewsScreenState extends State<TimelineReviewsScreen> {
  TextEditingController reviewController;
  ScrollController scrollController;
  Future getReviewsData;
  Customer customer;

  @override
  void initState() {
    super.initState();
    reviewController = new TextEditingController();
    scrollController = new ScrollController();
    customer = Customer();

    getReviewsData = customer.getTimelineReviews(widget.timeline.id);
  }

  @override
  void dispose() {
    super.dispose();
    reviewController.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: NormalText(widget.timeline.title, kblack, 20.0),
          backgroundColor: kwhite,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BoldText("Reviews", 20.0, kblack),
                      InkWell(
                        child: BoldText("Add review", 16, korange),
                        onTap: () {
                          showMyInputDialog(context, "Add Review", "Set new name.", reviewController, () async {
                            BackendMessage response = await customer.addTimelineReview(widget.timeline.id, reviewController.text);
                            Navigator.of(context).pop();
                            showMyDialog(context, response.status.toString(), response.status.toString() == 'success' ? 'Review added successfully' : response.message.toString() );
                            setState(() {
                              getReviewsData = customer.getTimelineReviews(widget.timeline.id);
                            });
                          });
                        },
                      )

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 1/5,
                    child: FutureBuilder(
                      future: getReviewsData,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                            else return createReviewsListView(context, snapshot);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Widget createReviewsListView(BuildContext context, AsyncSnapshot snapshot) {
    dynamic reviews = snapshot.data['message']['reviews'];
    int size = int.parse(snapshot.data['message']['size'].toString());
    // debugPrint('hotels:' + snapshot.data['message']['hotels'][0]['name'].toString());
    return new ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: size,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return reviewProfile(reviews[index]['user_name'].toString(), reviews[index]['review'].toString(), "05,Mar,2020");
      },
    );
  }
}
