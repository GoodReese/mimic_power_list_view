library mimic_power_list_view;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mimic_power_list_view/power_list/layout/manager/layout_manager.dart';
import 'package:mimic_power_list_view/power_list/controller/power_list_scroll_controller.dart';

import 'power_list/power_scroll_view.dart';

// demo  controller 都可以另外直接传入  不用buildNovelScrollController
// return MimicPowerListView.builder(
//       key: ValueKey(turnPageMode),
//       physics: const ScrollPhysics(),
//       // controller: controller,
//       controller: buildNovelScrollController(turnPageMode),
//       // controller: PowerListScrollSimulationController(),
//       addRepaintBoundaries: turnPageMode != ReaderTurnPageMode.simulationMode,
//       scrollDirection: Axis.horizontal,
//       layoutManager: buildNovelLayoutManager(turnPageMode),
//       debugTag: 'outerParent',
//       itemBuilder: (BuildContext context, int _index) {
//         return pageList[_index];
//         // return buildTestContentItem(constraints, _index);
//       },
//       itemCount: pageList.length,
//     );

class MimicPowerListView extends PowerListView {
  MimicPowerListView({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    List<Widget> children = const <Widget>[],
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    LayoutManager? layoutManager,
    String? debugTag,
  }) : super(
            key: key,
            scrollDirection: scrollDirection,
            reverse: reverse,
            controller: controller,
            primary: primary,
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            itemExtent: itemExtent,
            prototypeItem: prototypeItem,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            cacheExtent: cacheExtent,
            children: children,
            semanticChildCount: semanticChildCount,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
            layoutManager: layoutManager,
            debugTag: debugTag);

  MimicPowerListView.builder({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    ScrollController? controller,
    bool? primary,
    ScrollPhysics? physics,
    bool shrinkWrap = false,
    EdgeInsetsGeometry? padding,
    double? itemExtent,
    Widget? prototypeItem,
    required IndexedWidgetBuilder itemBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
    double? cacheExtent,
    int? semanticChildCount,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    ScrollViewKeyboardDismissBehavior keyboardDismissBehavior =
        ScrollViewKeyboardDismissBehavior.manual,
    String? restorationId,
    Clip clipBehavior = Clip.hardEdge,
    LayoutManager? layoutManager,
    String? debugTag,
  })  : assert(
            (!(controller is PowerListScrollController && controller.isLoop)) ||
                (itemCount != null && itemCount > 0),
            'if isLoop of controller is true , then the itemCount must be greater than 0 '),
        super.builder(
            key: key,
            scrollDirection: scrollDirection,
            reverse: reverse,
            controller: controller,
            primary: primary,
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            itemExtent: itemExtent,
            prototypeItem: prototypeItem,
            itemBuilder: (context, index) {
              bool isLoop = (controller is PowerListScrollController &&
                  controller.isLoop);
              return itemBuilder.call(
                  context, isLoop ? index % itemCount! : index);
            },
            itemCount:
                (controller is PowerListScrollController && controller.isLoop)
                    ? itemCount! + 1
                    : itemCount,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            cacheExtent: cacheExtent,
            semanticChildCount: semanticChildCount,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
            layoutManager: layoutManager,
            debugTag: debugTag);
}
