import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

const String appname = 'CAMLDP';
const String short_appname = "L.D.P";
const String title = 'សម្ព័ន្ធដើម្បីប្រជាធិបតេយ្យ';
const String slogan = 'រួមគិត រួមធ្វើ រួមទទួលខុសត្រូវ';
const String description =
    'គណ​បក្ស​សម្ព័ន្ធ​ដើម្បី​ប្រ​ជាធិប​តេយ្យ​(គ.ស.ប) ត្រូវ​បាន​​ផ្តួច​ផ្តើម​បង្កើត​ទ្បើង​នៅ​ថ្ងៃ​​១៥ ខែ​កក្កដា​ ឆ្នាំ​ ២០០៥​ ដោយ​ពលរដ្ឋ​មួយ​ក្រុម​តូច​ ដែល​មាន​ចិត្ត​គំនិត​ និង​ទស្សនៈ​ប្រ​ហាក់​ប្រហែល​ គ្នា​ក្នុង​ការ​ដោះ​ស្រាយ​បញ្ហា​សង្គម​ខ្មែរ​។ ក្រុម​ស្ថាប​និក​នេះ​ បាន​បំពេញ​បែប​បទ​បង្កើត ​គណ​បក្ស​សម្ព័ន្ធ​ដើម្បី​ប្រ​ជាធិប​តេយ្យ​ទ្បើង​ ស្រប​តាម​ច្បាប់​ស្តី​ពី ​គណ​បក្ស​នយោ​បាយ​ ហើយ​ក៏​បាន​ទទួល​ស្គាល់​ចុះ​បញ្ជី​ជា​ផ្លូវ​ការ​តាម​ប្រ​កាស​ក្រ​សួង​មហា​ ផ្ទៃ ​លេខ​៧៩២​ប្រ.ក​ ចុះ​ថ្ងៃទី​២៦​ ខែ​មិថុនា​ ឆ្នាំ​២០០៦​។';
const String apiUrl = 'http://news.camldp.org/wp-json/wp/v2/';
const String logo = 'assets/images/logo.png';
const String placeholder = 'assets/images/placeholder.png';
const String post = 'posts?_embed';
const String page = 'pages?_embed';
var bgColor = createMaterialColor(Color(0xFF00469A));
const Color maincolor = Color(0xFF00469A);
const Color secondcolor = Colors.blueAccent;
const bottomAds = 'assets/images/ads.gif';
const postAds = 'assets/images/ads.png';
const String contact_url = "http://news.camldp.org";
const String contact_phone = "+85510532003";
const String contact_email = "https://web.facebook.com/veasna.khem.8/";
const String contact_youtube = 'https://www.youtube.com/channel/UCV-mRPSggWtMotLjlwOYxgw?sub_confirmation=1';
const double contact_lat = 13.3825006;
const double contact_lng = 103.8543488;
const double contact_zoom = 12;
