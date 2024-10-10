// To parse this JSON data, do
//
//     final generalModel = generalModelFromJson(jsonString);

import 'dart:convert';

GeneralModel generalModelFromJson(String str) => GeneralModel.fromJson(json.decode(str));

String generalModelToJson(GeneralModel data) => json.encode(data.toJson());

class GeneralModel {
  double width;
  double height;
  double font_size_xxs;
  double font_size_xs;
  double font_size_sm;
  double font_size_m;
  double font_size_l;
  double font_size_xl;
  double font_size_xxl;
  bool isPortrait;
  bool isDarkMode;

  GeneralModel({
    required this.font_size_xxs,
    required this.font_size_xs,
    required this.font_size_sm,
    required this.font_size_m,
    required this.font_size_l,
    required this.font_size_xl,
    required this.font_size_xxl,
    required this.width,
    required this.height,
    required this.isPortrait,
    required this.isDarkMode
  });

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
    font_size_xxs: json["font_size_xxs"],
    font_size_xs: json["font_size_xs"],
    font_size_sm: json["font_size_sm"],
    font_size_m: json["font_size_m"],
    font_size_l: json["font_size_l"],
    font_size_xl: json["font_size_xl"],
    font_size_xxl: json["font_size_xxl"],
    width: json["width"],
    height: json["height"],
    isPortrait: json["isPortrait"],
    isDarkMode: json["isDarkMode"]
  );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "font_size_xxs": width * 0.025,
    "font_size_xs": width * 0.030,
    "font_size_sm": width * 0.035,
    "font_size_m": width * 0.040,
    "font_size_l": width * 0.045,
    "font_size_xl": width * 0.050,
    "font_size_xxl": width * 0.055,
    "isPortrait": isPortrait,
    "isDarkMode": isDarkMode,
  };
}
