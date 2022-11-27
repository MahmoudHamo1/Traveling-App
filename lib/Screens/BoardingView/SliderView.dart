import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trawell/Screens/BoardingView/sliderDots.dart';
import 'package:trawell/Screens/BoardingView/sliderItems.dart';
import 'package:trawell/utils/TextStyles.dart';
import 'package:trawell/utils/consts.dart';

import '../SignInPage.dart';
import 'Slider.dart';

class SliderLayoutView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SliderLayoutViewState();
}

class _SliderLayoutViewState extends State<SliderLayoutView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Container(
    child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: sliderArrayList.length,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                      child: BoldText(NEXT,14,kblack),

                    ),
                    onTap: () {
                      int page = (_pageController.page?.toInt()) as int;
                      _pageController.animateToPage( page + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn
                      );
                    },
                  )
                ),


                Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                      child: BoldText(SKIP,14,kblack),

                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SignInPage();
                      }));
                    },
                  )
                ),


                Container(
                  alignment: AlignmentDirectional.bottomCenter,
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < sliderArrayList.length; i++)
                        if (i == _currentPage)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                ),
              ],
            )
          ],
        )),
  );
}