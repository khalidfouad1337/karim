import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:myskin/const.dart';
import 'package:myskin/them.dart';

bool scratch = false;
void ft() {
  scratch = !scratch;
}

infoAlert(BuildContext context, ft) {
  CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      text: "Show ad for unlock !",
      confirmBtnText: "Watch",
      confirmBtnColor: const Color(0xffF37633),
      backgroundColor: AppTheme.gradientBottom,
      loopAnimation: true,
      barrierDismissible: true,
      onConfirmBtnTap: () {
        g_ads.rewardInstance.showRewardAd(ft);
        Navigator.of(context).pop();
      });
}

class Dialogs {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  // key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}

naviagetPage(BuildContext context, page) {
  Dialogs.showLoadingDialog(context);
  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop();
    g_ads.interInstance.showInterstitialAd();
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    });
  });
}
