import 'package:flutter/material.dart';
import 'package:myskin/ads/src/widgets/custom_banner.dart';
import 'package:myskin/const.dart';
import 'package:myskin/pages/page_content.dart';
import 'package:myskin/pages/page_myemote.dart';
import 'package:myskin/them.dart';
import 'package:myskin/widget/alert.dart';
import 'package:myskin/widget/widget_banner.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Aliens Skin Tool"),
          centerTitle: true,
          backgroundColor: AppTheme.gradienTop,
        ),
        body: WillPopScope(
          onWillPop: onWillpop,
          child: Stack(
            children: [
              Center(
                  child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.gradienTop,
                    AppTheme.gradientBottom,
                  ],
                )),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: g_ads.nativeInstance.getNativeAdWidget(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        image("normal", "Normal Emotes", _width),
                        image("rare", "Rate Emotes", _width),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        image("elite", "Elite Emotes", _width),
                        image("super", "Super Emotes", _width),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        naviagetPage(context, const PageMyEmotes());
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        height: _width * 0.14,
                        decoration: BoxDecoration(
                          color: AppTheme.buttonColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.star,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "My Alients",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 200),
                  ],
                ),
              )),
              WidgetBanner(
                gAdsBanner:
                    CustomBanner(key: UniqueKey(), ads: g_ads.bannerInstance),
              ),
            ],
          ),
        ));
  }

  Widget image(String img, String title, double _width) {
    return InkWell(
      onTap: () {
        naviagetPage(context, PageContent(title: title, category: img));
      },
      child: SizedBox(
        width: _width * 0.4,
        child: Image.asset("assets/$img.png"),
      ),
    );
  }
}
