import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> notifyInit() async {
  AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew_alert",
            channelName: "緊急地震速報",
            channelDescription: "地震速報預估最大震度 5 弱以上",
            playSound: true,
            soundSource: 'resource://raw/eew_alert',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew",
            channelName: "地震速報",
            channelDescription: "地震速報所在地預估震度 2 以上",
            playSound: true,
            soundSource: 'resource://raw/eew',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eew',
            channelKey: "eew_silence",
            channelName: "地震速報 (無聲通知)",
            channelDescription: "地震速報所在地預估震度 2 以下的區域",
            playSound: false,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: lowVibrationPattern),

        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "int_report",
            channelName: "震度速報",
            channelDescription: "TREM 觀測網所在地實測震度 3 以上",
            playSound: true,
            soundSource: 'resource://raw/int_report',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "eq",
            channelName: "強震監視器",
            channelDescription: "TREM 觀測網偵測到晃動",
            playSound: true,
            soundSource: 'resource://raw/eq',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "report",
            channelName: "地震報告",
            channelDescription: "地震報告所在地震度 3 以上",
            playSound: true,
            soundSource: 'resource://raw/report',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_eq',
            channelKey: "report_silence",
            channelName: "地震報告 (無聲通知)",
            channelDescription: "地震報告所在地震度 3 以下的地區",
            playSound: false,
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: lowVibrationPattern),

        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "thunderstorm",
            channelName: "大雷雨即時訊息",
            channelDescription: "所在地發布大雷雨即時訊息",
            playSound: true,
            soundSource: 'resource://raw/rain',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "rain_2",
            channelName: "大雨特報",
            channelDescription: "所在地發布大雨特報",
            playSound: true,
            soundSource: 'resource://raw/normal',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "rain_1",
            channelName: "豪雨特報",
            channelDescription: "所在地發布豪雨特報",
            playSound: true,
            soundSource: 'resource://raw/weather',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "flood",
            channelName: "淹水警戒",
            channelDescription: "所在地發布淹水警戒",
            playSound: true,
            soundSource: 'resource://raw/warn',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "tsunami",
            channelName: "海嘯警報 (警報)",
            channelDescription: "預估浪高 1 公尺以上",
            playSound: true,
            soundSource: 'resource://raw/tsunami',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "tsunami_warn",
            channelName: "海嘯警報 (注意)",
            channelDescription: "預估浪高 1 公尺以下",
            playSound: true,
            soundSource: 'resource://raw/warn',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "volcano",
            channelName: "火山資訊",
            channelDescription: "所在地發布火山資訊",
            playSound: true,
            soundSource: 'resource://raw/warn',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "heat",
            channelName: "高溫資訊",
            channelDescription: "所在地發布高溫資訊",
            playSound: true,
            soundSource: 'resource://raw/normal',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "typhoon",
            channelName: "颱風相關資訊",
            channelDescription: "所在地發布颱風相關資訊",
            playSound: true,
            soundSource: 'resource://raw/normal',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),

        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "other",
            channelName: "其他類型警報",
            channelDescription: "所在地發布其他類型警報",
            playSound: true,
            soundSource: 'resource://raw/normal',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
        NotificationChannel(
            channelGroupKey: 'group_info',
            channelKey: "announcement",
            channelName: "公告",
            channelDescription: "ExpTech 發布之公告",
            playSound: true,
            soundSource: 'resource://raw/info',
            defaultColor: Colors.red,
            ledColor: Colors.red,
            vibrationPattern: highVibrationPattern),
      ],
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: 'group_eew', channelGroupName: '地震速報音效'),
        NotificationChannelGroup(channelGroupKey: 'group_eq', channelGroupName: '地震資訊'),
        NotificationChannelGroup(channelGroupKey: 'group_info', channelGroupName: '防災資訊'),
        NotificationChannelGroup(channelGroupKey: 'group_other', channelGroupName: '其他'),
      ],
      debug: true);
}

Future<PermissionStatus> requestNotificationPermission() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications();
  }
  return isAllowed ? PermissionStatus.granted : PermissionStatus.denied;
}
