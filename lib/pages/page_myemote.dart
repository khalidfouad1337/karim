import 'package:flutter/material.dart';
import 'package:myskin/ads/src/widgets/custom_banner.dart';
import 'package:myskin/const.dart';
import 'package:myskin/pages/pageemoteresult.dart';
import 'package:myskin/them.dart';
import 'package:myskin/widget/alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageMyEmotes extends StatefulWidget {
  const PageMyEmotes({Key? key}) : super(key: key);

  @override
  State<PageMyEmotes> createState() => _PageMyEmotesState();
}

class _PageMyEmotesState extends State<PageMyEmotes> {
  List<String> imgs = [];
  int nbr = 0;
  getData() async {
    final SharedPreferences prefs = await pprefs;
    // print(prefs.getString('counter'));
    setState(() {
      imgs = (prefs.getString('counter') ?? "assets/normal/normal1.png")
          .split('|');
      nbr = imgs.length;
      print(imgs);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Aliens     ${nbr - 1} /40"),
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
                              // childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 0),
                      itemCount: imgs.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return ((index != imgs.length - 1))
                            ? InkWell(
                                onTap: () {
                                  naviagetPage(context,
                                      PageEmoteResult(img: imgs[index]));
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0x4fffffff),
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Image.asset(imgs[index])),
                              )
                            : Container();
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
      ),
    );
  }
}
