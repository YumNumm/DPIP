import 'package:dpip/util/extension/build_context.dart';
import 'package:dpip/widget/list/tile_group_header.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SettingsLocationView extends StatefulWidget {
  const SettingsLocationView({super.key});

  @override
  State<SettingsLocationView> createState() => _SettingsLocationViewState();
}

class _SettingsLocationViewState extends State<SettingsLocationView> {
  bool isAutoLocatingEnabled = false;

  Future toggleAutoLocation() async {
    if (isAutoLocatingEnabled) {
      setState(() {
        isAutoLocatingEnabled = false;
      });
    } else {
      // TODO: Check Permission and start location service

      setState(() {
        isAutoLocatingEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar.large(
              title: Text("所在地"),
            )
          ];
        },
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SwitchListTile(
                tileColor:
                    isAutoLocatingEnabled ? context.colors.primaryContainer : context.colors.surfaceContainerHighest,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: Text(
                  "啟用自動定位",
                  style: TextStyle(
                      color:
                          isAutoLocatingEnabled ? context.colors.onPrimaryContainer : context.colors.onSurfaceVariant),
                ),
                contentPadding: const EdgeInsets.fromLTRB(16, 4, 12, 4),
                value: isAutoLocatingEnabled,
                onChanged: (value) => toggleAutoLocation(),
              ),
            ),
            const ListTileGroupHeader(title: "所在地"),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Symbols.location_city),
              ),
              title: Text("縣市"),
              subtitle: Text(""),
              enabled: !isAutoLocatingEnabled,
            ),
            ListTile(
              leading: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Symbols.forest),
              ),
              title: Text("鄉鎮"),
              subtitle: Text(""),
              enabled: !isAutoLocatingEnabled,
            )
          ],
        ),
      ),
    );
  }
}
