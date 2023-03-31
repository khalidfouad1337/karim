import 'package:myskin/ads/networks.dart';
import 'package:myskin/ads/src/data/admob_data.dart';
import 'package:myskin/ads/src/data/applovin_data.dart';
import 'package:myskin/ads/src/data/fan_data.dart';
import 'package:myskin/ads/src/data/ironsource_data.dart';
import 'package:myskin/ads/src/data/settings_data.dart';
import 'package:myskin/ads/src/data/unity_data.dart';

class AdsData {
  final AdmobData admobData;
  final IronSourceData ironSourceData;
  final ApplovinData applovinData;
  final UnityData unityData;
  final FanData fanData;
  final Settings settings;

  AdsData.fromJson(Map<String, dynamic> json)
      : admobData = AdmobData.fromJson(json["ads"][Networks.admob]),
        ironSourceData =
            IronSourceData.fromJson(json["ads"][Networks.ironsource]),
        applovinData = ApplovinData.fromJson(json["ads"][Networks.applovin]),
        unityData = UnityData.fromJson(json["ads"][Networks.unity]),
        fanData = FanData.fromJson(json["ads"][Networks.fan]),
        settings = Settings.fromJson(json["ads"]["settings"]);
}
