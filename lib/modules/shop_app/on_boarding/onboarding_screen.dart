
import 'package:app_test/modules/shop_app/login/login_screen.dart';
import 'package:app_test/shared/components/components.dart';
import 'package:app_test/shared/network/local%20/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';
import 'onBoarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<OnBoardingModel> pages = [
    OnBoardingModel(
        title: "On Board Title 1",
        body: 'On Board Body 1',
        image: "assets/images/welcome.jpeg"),
    OnBoardingModel(
        title: "On Board Title 2",
        body: 'On Board Body 2',
        image: "assets/images/welcome.jpeg"),
    OnBoardingModel(
        title: "On Board Title 3",
        body: 'On Board Body 3',
        image: "assets/images/welcome.jpeg"),
  ];
  bool isLastScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(title: "SKIP", onPressed: (){
            submit();
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    if (index == pages.length - 1) {
                      setState(() {
                        isLastScreen = true;
                      });
                    }else{
                      setState(() {
                        isLastScreen = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildOnBoardingItem(pages[index])),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        activeDotColor: defaultColor,
                        expansionFactor: 4,
                        dotWidth: 10,
                        spacing: 5),
                    controller: pageController,
                    count: pages.length),
                const Spacer(),
                FloatingActionButton(
                    child: const Icon(Icons.arrow_circle_right),
                    onPressed: () {
                      if (isLastScreen) {
                        submit();
                      } else {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(OnBoardingModel page) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(page.image))),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            page.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            page.body,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
          ),
        ],
      );

  void submit(){
     CacheHelper.saveData(key: "onBoarding", value: true).then((value){
       if(value==true){
         navigateToAndFinish(context, ShopLoginScreen());
       }
     });
  }
}
