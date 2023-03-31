import 'package:flutter/material.dart';
import 'package:myskin/ads/src/widgets/custom_banner.dart';
import 'package:myskin/const.dart';
import 'package:myskin/them.dart';
import 'package:myskin/widget/drawer.dart';
import 'package:myskin/widget/widget_banner.dart';

class PageEmoteResult extends StatefulWidget {
  String img;
  PageEmoteResult({Key? key, required this.img}) : super(key: key);

  @override
  State<PageEmoteResult> createState() => _PageEmoteResultState();
}

class _PageEmoteResultState extends State<PageEmoteResult> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultat Aliens"),
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
                    Container(
                      height: _width * 0.7,
                      margin: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Image.asset(widget.img
                          // width: 203,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        button(Icons.share, "share"),
                        // button(Icons.download, "Save"),
                        button(Icons.star, " Rate"),
                      ],
                    ),
                    const SizedBox(height: 120)
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
      ),
    );
  }

  Widget button(IconData icon, String txt) {
    return InkWell(
      onTap: () {
        if (txt == "Share ") {
          linkShare();
        }
        if (txt == "  Rate  ") {
          linkRate();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color(0xffF37633),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(children: [
          Icon(
            icon,
            size: 35,
            color: Colors.white,
          ),
          const SizedBox(height: 5),
          Text(
            txt,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ]),
      ),
    );
  }
}
