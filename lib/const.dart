// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:myskin/ads/src/multi_ads_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> pprefs = SharedPreferences.getInstance();
late Future<String> emotes;

var configeApp;
var promoApp;
var donnes;
var cpa;
var ads;

late MultiAds g_ads;
const String jsonId = "1_FvsFR9N_yBNPIvKzd_0Tnyi9_A1rord";
const String pathJson =
    "https://drive.google.com/uc?export=download&id=$jsonId";
Future<bool> onWillpop() async {
  Future.delayed(const Duration(seconds: 2), () {
    g_ads.interInstance.showInterstitialAd();
    Future.delayed(const Duration(milliseconds: 500), () {});
  });
  return true;
}
