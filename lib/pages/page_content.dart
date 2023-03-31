import 'package:flutter/material.dart';
import 'package:myskin/ads/src/widgets/custom_banner.dart';
import 'package:myskin/const.dart';
import 'package:myskin/pages/pagescratch.dart';
import 'package:myskin/them.dart';
import 'package:myskin/widget/alert.dart';

class PageContent extends StatefulWidget {
  String title;
  String category;
  PageContent({Key? key, required this.title, required this.category})
      : super(key: key);

  @override
  State<PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<PageContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: AppTheme.gradienTop,
        ),
        body: WillPopScope(
          onWillPop: onWillpop,
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
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                //childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 0),
                        itemCount: 10,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              naviagetPage(
                                  context,
                                  ScratchCard(
                                      img:
                                          "assets/${widget.category}/${widget.category}${index + 1}.png"));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0x4fffffff),
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Image.asset(
                                "assets/${widget.category}/${widget.category}${index + 1}.png",
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  color: Colors.black,
                  child:
                      CustomBanner(key: UniqueKey(), ads: g_ads.bannerInstance),
                ),
              ],
            ),
          ),
        ));
  }
}
