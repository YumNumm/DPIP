import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dpip/api/exptech.dart';
import 'package:dpip/app/page/history/widgets/history_timeline_item.dart';
import 'package:dpip/app/page/history/widgets/timeline_item.dart';
import 'package:dpip/core/ios_get_location.dart';
import 'package:dpip/global.dart';
import 'package:dpip/model/history.dart';
import 'package:dpip/util/extension/build_context.dart';
import 'package:dpip/widget/error/region_out_of_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryLocationTab extends StatefulWidget {
  const HistoryLocationTab({super.key});

  @override
  State<HistoryLocationTab> createState() => _HistoryLocationTabState();
}

class _HistoryLocationTabState extends State<HistoryLocationTab> {
  final list = GlobalKey<RefreshIndicatorState>();
  bool isLoading = true;
  List<History> historyList = [];

  String? city;
  String? town;
  String? region;

  Future<void> refreshHistoryList() async {
    setState(() => isLoading = true);
    try {
      final data = await ExpTech().getHistoryRegion(region!);
      setState(() {
        historyList = data.reversed.toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS && (Global.preference.getBool("auto-location") ?? false)) {
      getSavedLocation();
    }
    final code = Global.preference.getInt("user-code");
    city = Global.location[code.toString()]?.city;
    town = Global.location[code.toString()]?.town;
    region = code?.toString();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      list.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    final grouped = groupBy(historyList, (e) => DateFormat(context.i18n.date_format).format(e.time.send));
    if (region == "-1") {
      return const RegionOutOfService();
    }

    return RefreshIndicator(
      key: list,
      onRefresh: refreshHistoryList,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: grouped.isEmpty ? 1 : grouped.length,
        itemBuilder: (context, index) {
          if (grouped.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: Text(context.i18n.home_safety),
              ),
            );
          }

          final key = grouped.keys.elementAt(index);
          final historyGroup = grouped[key]!;

          return Column(children: [
            TimelineItem(
              child: Text(
                key,
                style: context.theme.textTheme.labelLarge?.copyWith(color: context.colors.secondary),
              ),
            ),
            ...historyGroup.map((history) {
              return HistoryTimelineItem(
                history: history,
                last: index == historyList.length - 1,
              );
            })
          ]);
        },
      ),
    );
  }
}
