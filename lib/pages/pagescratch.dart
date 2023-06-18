// ignore_for_file: deprecated_member_use
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:myskin/ads/src/widgets/custom_banner.dart';
import 'package:myskin/them.dart';
import 'package:myskin/widget/alert.dart';
import 'package:myskin/widget/drawer.dart';
import 'package:myskin/widget/star.dart';
import 'package:myskin/widget/widget_banner.dart';
import 'package:scratcher/scratcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myskin/const.dart';

class ScratchCard extends StatefulWidget {
  String img;
  ScratchCard({Key? key, required this.img}) : super(key: key);

  @override
  _ScratchCardState createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  late ConfettiController _controllerCenter;
  double _opacity = 0.0;
  final Future<SharedPreferences> pprefs = SharedPreferences.getInstance();

  AssetsAudioPlayer player = AssetsAudioPlayer();
  String sound = "assets/sound.mp3";
  palySound(String soung) {
    player.open(
      Audio(soung),
      loopMode: LoopMode.single,
    );
  }

  @override
  void initState() {
    super.initState();

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  Future<void> _addEmotes(String img) async {
    final SharedPreferences prefs = await pprefs;
    final String counter = (prefs.getString('counter') ?? "") + "$img|";

    setState(() {
      emotes = prefs.setString('counter', counter).then((bool success) {
        print(prefs.getString('counter'));
        return counter;
      });
    });
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Scratch Card To get Alien"),
          backgroundColor: AppTheme.gradienTop,
        ),
        body: WillPopScope(
          onWillPop: onWillpop,
          child: Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.gradienTop,
                      AppTheme.gradientBottom,
                    ],
                  )),
                  alignment: Alignment.center,
                  child: SafeArea(
                    child: Stack(
                      children: [
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: _width * 0.7,
                              margin: const EdgeInsets.all(20),
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0x4fffffff),
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Image.asset(widget.img
                                  // width: 203,
                                  ),
                            ),
                            InkWell(
                              onTap: () {
                                if (scratch) {
                                  scratchDialog(context);
                                } else {
                                  setState(() {
                                    infoAlert(context, ft);
                                  });
                                }
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 40, right: 40),
                                height: _width * 0.14,
                                decoration: BoxDecoration(
                                  color: AppTheme.buttonColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        !scratch ? Icons.lock : Icons.lock_open,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      // Image.asset(
                                      //   "assets/normal/nor1.png",
                                      //   // width: 203,
                                      // ),
                                      const Text(
                                        "Scratch Card",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ]),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                button(Icons.share, "Share "),
                                button(Icons.star, "  Rate  "),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: ConfettiWidget(
                            confettiController: _controllerCenter,
                            blastDirectionality: BlastDirectionality
                                .explosive, // don't specify a direction, blast randomly
                            shouldLoop:
                                true, // start again as soon as the animation is finished
                            colors: const [
                              Colors.green,
                              Colors.blue,
                              Colors.pink,
                              Colors.orange,
                              Colors.purple
                            ], // manually specify the colors to be used
                            createParticlePath:
                                drawStar, // define a custom shape/path.
                          ),
                        ),
                      ],
                    ),
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

  Future<void> scratchDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Column(
              children: const [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "You Earned Gift",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Scratcher(
                color: AppTheme.buttonColor,
                accuracy: ScratchAccuracy.low,
                threshold: 30,
                brushSize: 40,
                onChange: (double r) {
                  print(r);
                  if (r > 97.0) {
                    Navigator.of(context).pop();
                    _controllerCenter.play();
                    palySound(sound);
                    _addEmotes(widget.img);
                    scratch = false;
                  }
                },
                onThreshold: () {
                  setState(() {
                    _opacity = 1;
                  });
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: _opacity,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      children: [
                        const Text(
                          "Hurray ! you won",
                          style: TextStyle(
                            color: Color(0xffF37633),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                            child: Image.asset(
                          widget.img,
                          // width: 203,
                        ))
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        });
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
