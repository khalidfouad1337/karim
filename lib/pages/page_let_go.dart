import 'package:flutter/material.dart';
import 'package:myskin/ads/src/widgets/custom_banner.dart';
import 'package:myskin/const.dart';
import 'package:myskin/pages/page_home.dart';
import 'package:myskin/them.dart';
import 'package:myskin/widget/alert.dart';
import 'package:myskin/widget/drawer.dart';
import 'package:myskin/widget/widget_banner.dart';

class PageLetGo extends StatefulWidget {
  const PageLetGo({Key? key}) : super(key: key);

  @override
  State<PageLetGo> createState() => _PageLetGoState();
}

class _PageLetGoState extends State<PageLetGo> {
  @override
  Widget build(BuildContext context) {
    double _widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Aliens Skin Tool"),
          centerTitle: true,
          backgroundColor: AppTheme.gradienTop,
        ),
        drawer: ftDrawer(context),
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
                      InkWell(
                        onTap: () {
                          naviagetPage(context, const PageHome());
                        },
                        child: Image.asset("assets/frame.png"),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          button(Icons.share, "Share"),
                          button(Icons.privacy_tip, "Security"),
                          button(Icons.star, "  Rate "),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              WidgetBanner(
                gAdsBanner:
                    CustomBanner(key: UniqueKey(), ads: g_ads.bannerInstance),
              ),
            ],
          ),
        ));
  }

  Widget button(IconData icon, String txt) {
    return InkWell(
      onTap: () {
        if (txt == "Share") {
          linkShare();
        }
        if (txt == "Security") {
          linkPolicy();
        }
        if (txt == "  Rate ") {
          linkRate();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppTheme.buttonColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(children: [
          Icon(
            icon,
            size: 35,
          ),
          const SizedBox(height: 5),
          Text(
            txt,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ]),
      ),
    );
  }
}
