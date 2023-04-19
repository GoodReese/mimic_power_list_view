import 'package:flutter/material.dart';

import '../power_list/controller/power_list_scroll_controller.dart';
import '../power_list/layout/manager/layout_manager.dart';
import '../turn_mode/novel_layout_manager.dart';
import '../turn_mode/simulation/controller/power_list_scroll_simulation_controller.dart';
import '../turn_mode/simulation/power_list_simulation_layout_manager.dart';

enum ReaderTurnPageMode { normalMode, coverMode, simulationMode }

PowerListPageScrollController? buildNovelScrollController(
    ReaderTurnPageMode turnPageMode) {
  switch (turnPageMode) {
    case ReaderTurnPageMode.coverMode:
      return PowerListPageScrollController();
    case ReaderTurnPageMode.simulationMode:
      return PowerListScrollSimulationController();
    case ReaderTurnPageMode.normalMode:
    default:
      return PowerListPageScrollController();
  }
}

LayoutManager? buildNovelLayoutManager(
    ReaderTurnPageMode turnPageMode, Color bgColor) {
  switch (turnPageMode) {
    case ReaderTurnPageMode.coverMode:
      return PowerListCoverLayoutManager();
    case ReaderTurnPageMode.simulationMode:
      return PowerListSimulationTurnLayoutManager(bgColor: bgColor);
    case ReaderTurnPageMode.normalMode:
    default:
      return PowerListLinearLayoutManager();
  }
}
