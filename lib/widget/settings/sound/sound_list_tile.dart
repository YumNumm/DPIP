import "dart:io";

import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:dpip/api/exptech.dart";
import "package:dpip/global.dart";
import "package:dpip/core/ios_get_location.dart";
import "package:dpip/util/need_location.dart";

class SoundListTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final String file;
  final bool? enable;

  const SoundListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.file,
    this.enable = true,
  });

  @override
  SoundListTileState createState() => SoundListTileState();
}

class SoundListTileState extends State<SoundListTile> {
  bool isPlaying = false;
  double userLat = 0;
  double userLon = 0;
  bool isUserLocationValid = false;

  void _initUserLocation() async {
    if (Platform.isIOS && (Global.preference.getBool("auto-location") ?? false)) {
      await getSavedLocation();
    }

    if (!mounted) return;

    userLat = Global.preference.getDouble("user-lat") ?? 0.0;
    userLon = Global.preference.getDouble("user-lon") ?? 0.0;

    isUserLocationValid = (userLon == 0 || userLat == 0) ? false : true;
  }

  void playSound() async {
    if (!widget.enable!) return;
    _initUserLocation();
    if (!isUserLocationValid && !(Global.preference.getBool("auto-location") ?? false)) {
      await showLocationDialog(context);
    } else {
      String token = Global.preference.getString("fcm-token") ?? "";
      if (token != "") {
        await ExpTech().sendNotifyTest(token, widget.file, userLat.toString(), userLon.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: !widget.enable!
          ? const Icon(Symbols.disabled_by_default_rounded, fill: 1)
          : const Icon(Symbols.play_circle, fill: 1),
      title: Text("${widget.title}${!widget.enable! ? " (未啟用)" : ""}"),
      subtitle: Text(widget.subtitle),
      onTap: playSound,
    );
  }
}
