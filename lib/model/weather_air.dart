import 'package:json_annotation/json_annotation.dart';

part 'weather_air.g.dart';

@JsonSerializable()
class weatherAir {
  /// 空氣一氧化碳
  final int co;

  /// 空氣二氧化氮
  final int no2;

  /// 空氣臭氧
  final int o3;

  /// 空氣pm2.5
  final int pm25;

  /// 空氣pm10
  final int pm10;

  /// 空氣二氧化硫
  final int so2;

  /// 空氣
  final int gbdefraindex;

  /// 空氣
  final int usepaindex;

  const weatherAir({
    required this.co,
    required this.no2,
    required this.o3,
    required this.pm25,
    required this.pm10,
    required this.so2,
    required this.gbdefraindex,
    required this.usepaindex,
  });

  static fromJson(Map<String, dynamic> json) {}
}
