import 'dart:io';

import 'package:dpip/api/exptech.dart';
import 'package:dpip/app/page/history/tabs/country.dart';
import 'package:dpip/app/page/history/tabs/location.dart';
import 'package:dpip/core/ios_get_location.dart';
import 'package:dpip/global.dart';
import 'package:dpip/model/history.dart';
import 'package:dpip/route/settings/settings.dart';
import 'package:dpip/util/extension/build_context.dart';
import 'package:dpip/util/list_icon.dart';
import 'package:dpip/widget/error/region_out_of_service.dart';
import 'package:dpip/widget/home/event_list_route.dart';
import 'package:dpip/widget/list/timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:timezone/timezone.dart';

class HistoryPage extends StatefulWidget {
  final Function()? onPositionUpdate;

  const HistoryPage({super.key, this.onPositionUpdate});

  @override
  State<HistoryPage> createState() => _HistoryPageState();

  static void updatePosition() => _activeCallback?.call();

  static void setActiveCallback(VoidCallback callback) => _activeCallback = callback;

  static void clearActiveCallback() => _activeCallback = null;

  static VoidCallback? _activeCallback;
}

class _HistoryPageState extends State<HistoryPage> with TickerProviderStateMixin {
  List<History> historyList = [];
  bool country = false;
  bool isLoading = true;
  String? region;
  String city = '';
  String town = '';

  late final controller = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
    // HistoryPage.setActiveCallback(_handlePositionUpdate);
  }

/* 
  void _handlePositionUpdate() {
    if (mounted) {
      _initData();
      widget.onPositionUpdate?.call();
    }
  }

  Future<void> refreshHistoryList() async {
    if (region == null && !country) return;
    setState(() => isLoading = true);
    try {
      final data = country ? await ExpTech().getHistory() : await ExpTech().getHistoryRegion(region!);
      if (mounted) {
        setState(() {
          historyList = data.reversed.toList();
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Widget _buildLocationButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            settings: const RouteSettings(name: '/settings'),
            builder: (context) => const SettingsRoute(initialRoute: '/location'),
          ),
        ),
        icon: const Icon(Symbols.pin_drop_rounded),
        label: Text('$city$town', style: const TextStyle(fontSize: 20)),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            title: Text(context.i18n.history),
            bottom: TabBar(
              controller: controller,
              tabs: [
                Tab(
                  icon: const Icon(Symbols.public_rounded),
                  text: context.i18n.home_area,
                ),
                Tab(
                  icon: const Icon(Symbols.home_rounded),
                  text: context.i18n.settings_location,
                ),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: controller,
        children: const [
          HistoryCountryTab(),
          HistoryLocationTab(),
        ],
      ),
    );
  } /* 

  Widget _buildLocationToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SegmentedButton(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            label: const Text("全國"),
            icon: const Icon(Symbols.public_rounded),
            tooltip: context.i18n.home_area,
            value: true,
          ),
          ButtonSegment(
            label: const Text("所在地"),
            icon: const Icon(Symbols.home_rounded),
            tooltip: context.i18n.settings_location,
            value: false,
          ),
        ],
        selected: {country},
        onSelectionChanged: (p0) => setState(() {
          country = p0.first;
          refreshHistoryList();
        }),
      ),
    );
  }

  TZDateTime _convertToTZDateTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    TZDateTime taipeTime = TZDateTime.from(dateTime, getLocation('Asia/Taipei'));
    return taipeTime;
  }

  Widget _buildHistoryList() {
    if (region == null && !country) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.only(top: 128),
          child: RegionOutOfService(),
        ),
      );
    }

    if (isLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (historyList.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(child: Text(context.i18n.no_historical_events)),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                context.i18n.historical_events,
                style: context.theme.textTheme.headlineSmall,
              ),
            );
          }
          final historyIndex = index - 1;
          final history = historyList[historyIndex];
          final showDate = historyIndex == 0 || history.time.send.day != historyList[historyIndex - 1].time.send.day;

          final int expireTimestamp = history.time.expires['all'];
          final TZDateTime expireTimeUTC = _convertToTZDateTime(expireTimestamp);
          final bool isExpired = TZDateTime.now(UTC).isAfter(expireTimeUTC.toUtc());

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TimeLineTile(
              time: history.time.send,
              icon: Icon(ListIcons.getListIcon(history.icon),
                  color: isExpired ? context.colors.onError : context.colors.onSecondaryContainer),
              height: 140,
              first: historyIndex == 0,
              showDate: showDate,
              color: isExpired ? context.colors.error : context.colors.secondaryContainer,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history.text.content["all"]!.subtitle,
                          style: context.theme.textTheme.titleMedium,
                        ),
                        Text(
                          history.text.description["all"]!,
                        ),
                      ],
                    ),
                  ),
                  if (shouldShowArrow(history))
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                ],
              ),
              onTap: () => handleEventList(context, history),
            ),
          );
        },
        childCount: historyList.isEmpty ? 1 : historyList.length + 1,
      ),
    );
  }
 */

  @override
  void dispose() {
    HistoryPage.clearActiveCallback();
    super.dispose();
  }
}
