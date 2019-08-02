import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:firebase_admob/firebase_admob.dart';

List android_banners = [
  {
    "id": "ca-app-pub-7786792021334163/5589116958",
  },
  {
    "id": "ca-app-pub-7786792021334163/7465794071",
  },
  {
    "id": "ca-app-pub-7786792021334163/9506043177",
  },
  {
    "id": "ca-app-pub-7786792021334163/8319710743",
  },
  {
    "id": "ca-app-pub-7786792021334163/7781897963",
  },
  {
    "id": "ca-app-pub-7786792021334163/8128139059",
  },
  {
    "id": "ca-app-pub-7786792021334163/1216489617",
  },
  {
    "id": "ca-app-pub-7786792021334163/2098326446",
  },
  {
    "id": "ca-app-pub-7786792021334163/9122899793",
  },
  {
    "id": "ca-app-pub-7786792021334163/7540201296",
  },
];

List android_intervals = [
  {
    "id": "ca-app-pub-7786792021334163/3481828367",
  },
  {
    "id": "ca-app-pub-7786792021334163/9066650358",
  },
  {
    "id": "ca-app-pub-7786792021334163/3602570686",
  },
  {
    "id": "ca-app-pub-7786792021334163/6531206108",
  },
  {
    "id": "ca-app-pub-7786792021334163/3687574432",
  },
  {
    "id": "ca-app-pub-7786792021334163/6122166089",
  },
  {
    "id": "ca-app-pub-7786792021334163/5792839506",
  },
  {
    "id": "ca-app-pub-7786792021334163/8227431156",
  },
  {
    "id": "ca-app-pub-7786792021334163/3579763227",
  },
  {
    "id": "ca-app-pub-7786792021334163/5026552746",
  },
];

Random rnd = Random();
int min = 0;
int max = android_banners.length - 1;
var r = min + rnd.nextInt(max - min);

String randomBanners() {
  Timer(Duration(seconds: 1), () {
    if (r < max) {
      r++;
    } else {
      r = 0;
    }
  });
  return android_banners[r]['id'];
}

String randomIntervals() {
    Timer(Duration(seconds: 1), () {
    if (r < max) {
      r++;
    } else {
      r = 0;
    }
  });
  return android_intervals[r]['id'];
}

String getAppId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7001768182379562~3946777232';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-7786792021334163~4715018987';
  }
  return null;
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7001768182379562~3946777232';
  } else if (Platform.isAndroid) {
    return randomBanners();
  }
  return null;
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-7001768182379562~3946777232';
  } else if (Platform.isAndroid) {
    return randomIntervals();
  }
  return null;
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['ibm', 'computers', 'mobile', 'app'],
  // nonPersonalizedAds: true,
  contentUrl: 'http://www.ibm.com',
  // keywords: <String>['flutterio', 'beautiful apps'],
  // contentUrl: 'https://flutter.io',
  testDevices: <String>[
    'D719B379AE2D0FA60902DD33E72E4A4E'
  ], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: getBannerAdUnitId(),
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: getInterstitialAdUnitId(),
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);
