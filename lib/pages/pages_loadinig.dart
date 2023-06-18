import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:myskin/ads/src/multi_ads_factory.dart';
import 'package:myskin/const.dart';
import 'package:myskin/pages/page_let_go.dart';
import 'package:myskin/widget/toas.dart';
import 'package:http/http.dart' as http;

class PageLoading extends StatefulWidget {
  const PageLoading({Key? key}) : super(key: key);

  @override
  State<PageLoading> createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {
  @override
  void initState() {
    super.initState();
    fetchAdsData();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg.png"), fit: BoxFit.cover),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                SizedBox(
                  height: 200,
                  //child: Image.asset("assets/playstore.png"),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (isLoading)
                    ? const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 40.0,
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red)),
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          fetchAdsData();
                        },
                        child: const Text(
                          "Try again",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  bool isLoading = true;
  Future<void> fetchAdsData() async {
    try {
      var url = Uri.parse(pathJson);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data2 = json.decode(response.body);
        g_ads = MultiAds(response.body);
        await g_ads.init();
        await g_ads.loadAds();
        setState(() {
          donnes = data2['posts'];
          configeApp = data2["config"];
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PageLetGo()),
            );
          });
        });
      } else {
        await Future.delayed(const Duration(seconds: 2), () {
          toas(context, "YOU ARE NOT CONNECTED");
          setState(() {
            isLoading = false;
          });
        });
      }
    } catch (e) {
      print(e);

      await Future.delayed(const Duration(seconds: 2), () {
        toas(context, "YOU ARE NOT CONNECTED");
        setState(() {
          isLoading = false;
        });
      });
    }
  }
}
