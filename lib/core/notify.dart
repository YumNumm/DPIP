import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> notifyInit() async {
  AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew_alert",
            channelName: "緊急地震速報(重大)",
            channelDescription: "最大震度 5 弱以上以及所在地(鄉鎮)預估震度 4 以上",
            importance: NotificationImportance.Max,
            defaultPrivacy: NotificationPrivacy.Public,
            criticalAlerts: true,
            playSound: true,
            soundSource: 'resource://raw/eew_alert',
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: highVibrationPattern,
            locked: true),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew",
            channelName: "緊急地震速報",
            channelDescription: "最大震度 5 弱以上以及所在地(鄉鎮)預估震度 2 以上",
            importance: NotificationImportance.Max,
            defaultPrivacy: NotificationPrivacy.Public,
            criticalAlerts: true,
            playSound: true,
            soundSource: 'resource://raw/eew',
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: mediumVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew",
            channelName: "緊急地震速報(無聲通知)",
            channelDescription: "最大震度 5 弱以上以及所在地(鄉鎮)預估震度 1 以上",
            importance: NotificationImportance.Low,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: false,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: lowVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew",
            channelName: "地震速報(重大)",
            channelDescription: "所在地(鄉鎮)預估震度 4 以上",
            importance: NotificationImportance.Max,
            defaultPrivacy: NotificationPrivacy.Public,
            criticalAlerts: true,
            playSound: true,
            soundSource: 'resource://raw/eew',
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: highVibrationPattern,
            locked: true),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew",
            channelName: "地震速報",
            channelDescription: "所在地(鄉鎮)預估震度 2 以上",
            importance: NotificationImportance.Max,
            defaultPrivacy: NotificationPrivacy.Public,
            criticalAlerts: true,
            playSound: true,
            soundSource: 'resource://raw/eew',
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: mediumVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew_silence",
            channelName: "地震速報 (無聲通知)",
            channelDescription: "所在地(鄉鎮)預估震度 1 以上",
            importance: NotificationImportance.Low,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: false,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: lowVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "int_report",
            channelName: "震度速報",
            channelDescription: "所在地(鄉鎮)實測震度 3 以上",
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/int_report',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "int_report_silence",
            channelName: "震度速報 (無聲通知)",
            channelDescription: "所在地(鄉鎮)實測震度 1 以上",
            importance: NotificationImportance.Low,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: false,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: lowVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "eq",
            channelName: "強震監視器",
            channelDescription: "偵測到晃動",
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/eq',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: mediumVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "report",
            channelName: "地震報告",
            channelDescription: "地震報告所在地震度 3 以上",
            importance: NotificationImportance.Default,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/report',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: lowVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "report_silence",
            channelName: "地震報告 (無聲通知)",
            channelDescription: "地震報告所在地震度 3 以下的地區",
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.Min,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: false,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: false),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "thunderstorm",
            channelName: "雷雨即時訊息",
            channelDescription: "所在地(鄉鎮)發布雷雨即時訊息或山區暴雨時",
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/rain',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: mediumVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "weather",
            channelName: "天氣警特報(重大)",
            channelDescription: "所在地(鄉鎮)發布紅色燈號之天氣警特報",
            importance: NotificationImportance.Max,
            defaultPrivacy: NotificationPrivacy.Public,
            criticalAlerts: true,
            playSound: true,
            soundSource: 'resource://raw/weather',
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: highVibrationPattern,
            locked: true),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "rain_2",
            channelName: "天氣警特報",
            channelDescription: "所在地(鄉鎮)發布上述除外燈號之天氣警特報",
            importance: NotificationImportance.Default,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/normal',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: mediumVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "rain_1",
            channelName: "避難資訊(重大)",
            channelDescription: "所在地(鄉鎮)發布防空、土石流、淹水或堰塞湖避難警訊時",
            importance: NotificationImportance.Max,
            defaultPrivacy: NotificationPrivacy.Public,
            criticalAlerts: true,
            playSound: true,
            soundSource: 'resource://raw/warn',
            defaultRingtoneType: DefaultRingtoneType.Alarm,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: highVibrationPattern,
            locked: true),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "flood",
            channelName: "避難資訊",
            channelDescription: "所在地(鄉鎮)發布防空、土石流、淹水或堰塞湖避難警訊時",
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/warn',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: mediumVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "tsunami_warn",
            channelName: "海嘯資訊(重大)",
            channelDescription: "海嘯警報發布時，沿海地區鄉鎮",
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/tsunami',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: mediumVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "tsunami",
            channelName: "海嘯資訊",
            channelDescription: "海嘯警報發布時，上述除外地區",
            importance: NotificationImportance.Default,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/warn',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: lowVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "tsunami_pacific_silent",
            channelName: "太平洋海嘯消息 (無聲通知)",
            channelDescription: "地震報告所在地震度 3 以下的地區",
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.Min,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: false,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: false),
        NotificationChannel(
            channelGroupKey: 'group_other',
            channelKey: "announcement",
            channelName: "其他通知",
            channelDescription: "發送公告時",
            importance: NotificationImportance.Default,
            defaultPrivacy: NotificationPrivacy.Public,
            playSound: true,
            soundSource: 'resource://raw/info',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            enableVibration: true,
            vibrationPattern: lowVibrationPattern),
      ],
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: 'group_eew', channelGroupName: '地震速報音效'),
        NotificationChannelGroup(channelGroupKey: 'group_eq', channelGroupName: '地震資訊'),
        NotificationChannelGroup(channelGroupKey: 'group_info', channelGroupName: '防災資訊'),
        NotificationChannelGroup(channelGroupKey: 'group_other', channelGroupName: '其他'),
      ],
      debug: true);
}
