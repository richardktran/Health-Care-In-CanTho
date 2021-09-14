import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_healthcare/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: AssetImage(
                                  'assets/images/first_start_icon.png'),
                              width: 186,
                              height: 100),
                          CarouselSlider.builder(
                            carouselController: controller.carouselController,
                            options: CarouselOptions(
                                height: MediaQuery.of(context).size.width + 50,
                                viewportFraction: 1,
                                initialPage: 0,
                                enableInfiniteScroll: false,
                                onPageChanged: (index, reason) {
                                  controller.activeIndex.value = index;
                                  controller.changeButton(index);
                                }),
                            itemCount: controller.urlImages.length,
                            itemBuilder: (context, index, realIndex) {
                              final urlImage = controller.urlImages[index];
                              final textBelowImage =
                                  controller.textBelowImages[index];
                              final note = controller.notes[index];
                              return buildImage(
                                  urlImage, textBelowImage, note, index);
                            },
                          ),
                        ]),
                    buildIndicator(),
                    ConstrainedBox(
                      constraints: BoxConstraints(minWidth: 100, minHeight: 50),
                      child: TextButton(
                          onPressed: controller.next,
                          child: Text(
                            controller.textButton,
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ButtonStyle(
                              backgroundColor: controller.bgColor.value,
                              foregroundColor: controller.fgColor.value,
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Colors.blueAccent))))),
                    )
                  ],
                ))));
  }

  Widget buildImage(
          String urlImage, String textBelowImage, String note, int index) =>
      Container(
          padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(urlImage),
                      ),
                    ),
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(textBelowImage, style: TextStyle(fontSize: 20)),
                  Text(note)
                ])
              ]));

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        activeIndex: controller.activeIndex.value,
        count: controller.urlImages.length);
  }
}