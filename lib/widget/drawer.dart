import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myskin/const.dart';
import 'package:myskin/them.dart';
import 'package:myskin/widget/utils.dart';
import 'package:share/share.dart';

Widget ftDrawer(BuildContext context) {
  return Drawer(
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
      child: Center(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 20),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 250,
                child: Image.asset("assets/playstore.png"),
              ),
              SizedBox(height: 30),
              drawer(Icons.star_rate, "Rate App", linkRate),
              drawer(FontAwesomeIcons.share, "Share Apps", linkShare),
              drawer(FontAwesomeIcons.googlePlay, "Others Apps", linkDeveloper),
              drawer(Icons.mail, "Send suggestions", linkEmail),
              drawer(Icons.policy, "Privacy Policy", linkPolicy),
            ]),
      ),
    ),
  );
}

//
// home(BuildContext context) {
//   Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) =>   Null()));
// }

linkRate() {
  Utils.openLink(
      url:
          'http://play.google.com/store/apps/details?id=${configeApp["package"]}');
}

linkDeveloper() {
  Utils.openLink(url: '${configeApp["developer"]}');
}

linkEmail() {
  Utils.openEmail(
      toEmail: configeApp["email"],
      subject: "suggestion for devLho",
      body: " ");
}

linkPolicy() {
  Utils.openLink(url: configeApp["policy"]);
}

linkShare() {
  Share.share("""
Best Alines games : 
http://play.google.com/store/apps/details?id=${configeApp["package"]}
""");
}

Widget drawer(IconData icon, String txt, Function fct) {
  return Container(
    margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
    decoration: BoxDecoration(
        color: AppTheme.buttonColor,
        borderRadius: const BorderRadius.all(Radius.circular(30))),
    child: ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 32,
      ),
      title: Text(
        txt,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onTap: () {
        fct();
      },
      focusColor: Colors.red,
    ),
  );
}
