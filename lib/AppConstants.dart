import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';

const kMainTextStyle = TextStyle(
  fontSize: 13,
);
TextStyle kYellowColorStyle = TextStyle(
  color: Colors.yellow[800],
);
const kGreyColorStyle = TextStyle(
  color: Colors.white,
  fontSize: 17
);
const kCategoryIcons = {
  'technology': Icons.settings_input_component,
  'business': FrinoIcons.f_briefcase,
  'entertainment': FrinoIcons.f_wand,
  'general': FrinoIcons.f_earth,
  'health': FrinoIcons.f_medicine,
  'sports': FrinoIcons.f_gym,
  'science': FrinoIcons.f_lab,
};

const kCheckBoxTitleStyle = TextStyle(color: Colors.grey);

final kTextFieldMainDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: Colors.yellow[700],
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      width: 1,
      color: Colors.yellow[700],
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      width: 1,
      color: Colors.grey,
    ),
  ),
);

// FloatingActionButton mainFloatActionButton(BuildContext context) =>
//     FloatingActionButton.extended(
//       label: Text('Categories', style: TextStyle(color: Colors.white)),
//       backgroundColor: Colors.yellow[800],
//       onPressed: () => Navigator.pushReplacementNamed(context, 'CS'),
//     );

const countryIOS2 = {
  'United Arab Emirates': 'ae',
  'Argentina': 'ar',
  'Austria': 'at',
  'Australia': 'au',
  'Belgium': 'be',
  'Bulgaria': 'bg',
  'Brazil': 'br',
  'Canada': 'ca',
  'Switzerland': 'ch',
  'China': 'cn',
  'Colombia': 'co',
  'Cuba': 'cu',
  'Czechia': 'cz',
  'Germany': 'de',
  'Egypt': 'eg',
  'France': 'fr',
  'United Kingdom of Great Britain and Northen Irelan': 'gb',
  'greece': 'gr',
  'Hong Kong': 'hk',
  'Hungary': 'hu',
  'Indonesia': 'id',
  'Ireland': 'ie',
  'India': 'in',
  'Italy': 'it',
  'Japan': 'jp',
  'Korea': 'kr',
  'Lithuania': 'lt',
  'Latvia': 'lv',
  'Morocco': 'ma',
  'Mexico': 'mx',
  'Malaysia': 'my',
  'Nigeria': 'ng',
  'Nicaragua': 'nl',
  'Norway': 'no',
  'New Zealand': 'nz',
  'Philippines': 'ph',
  'Poland': 'pl',
  'Portugal': 'pt',
  'Romania': 'ro',
  'Serbia': 'rs',
  'Russian Federation': 'ru',
  'Saudi Arabia': 'sa',
  'Sweden': 'se',
  'Singapore': 'sg',
  'Slovenia': 'si',
  'Slovakia': 'sk',
  'Thailand': 'th',
  'Turkey': 'tr',
  'Taiwan': 'tw',
  'Ukraine': 'ua',
  'Uniated States of America': 'us',
  'Venezuela': 've',
  'South Africa': 'za',
};
