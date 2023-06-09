import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'controller/power_list_scroll_controller.dart';
import 'layout/manager/layout_manager.dart';
import 'notify/power_list_data_notify.dart';
import 'sliver/power_scrollable.dart';
import 'sliver/power_sliver.dart';
import 'sliver/viewport/power_list_viewport.dart';

class PowerListView extends ListView {
  PowerListView({
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
    this.layoutManager,
    this.debugTag,
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
            clipBehavior: clipBehavior);

  PowerListView.builder({
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
    this.layoutManager,
    this.debugTag,
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
            clipBehavior: clipBehavior);

  final LayoutManager? layoutManager;
  final String? debugTag;

  @override
  Widget buildChildLayout(BuildContext context) {
    if (controller is PowerListPageScrollController) {
      return PowerSliverFillViewportRenderObjectWidget(
        viewportFraction:
            (controller! as PowerListPageScrollController).viewportFraction,
        delegate: childrenDelegate,
        layoutManager: layoutManager ?? PowerListLinearLayoutManager(),
      );
    }

    if (itemExtent != null) {
      return SliverFixedExtentList(
        delegate: childrenDelegate,
        itemExtent: itemExtent!,
      );
    } else if (prototypeItem != null) {
      return SliverPrototypeExtentList(
        delegate: childrenDelegate,
        prototypeItem: prototypeItem!,
      );
    }
    return PowerSliverList(
      delegate: childrenDelegate,
      layoutManager: layoutManager ?? PowerListLinearLayoutManager(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> slivers = buildSlivers(context);
    final AxisDirection axisDirection = getDirection(context);
    var gestureNotify = PowerListGestureDataNotify();

    final ScrollController? scrollController =
        primary == true ? PrimaryScrollController.of(context) : controller;

    final PowerScrollable scrollable = PowerScrollable(
      dragStartBehavior: dragStartBehavior,
      axisDirection: axisDirection,
      controller: scrollController,
      physics: physics,
      scrollBehavior: scrollBehavior,
      semanticChildCount: semanticChildCount,
      restorationId: restorationId,
      debugTag: debugTag,
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return buildViewport(context, offset, axisDirection, slivers);
      },
    );
    final Widget scrollableResult = primary == true && scrollController != null
        ? PrimaryScrollController.none(child: scrollable)
        : scrollable;

    final Widget itemResult = PowerListDataInheritedWidget(
      indexNotify: PowerListIndexDataNotify(),
      gestureNotify: gestureNotify,
      child: Listener(
        onPointerDown: (PointerDownEvent downEvent) {
          gestureNotify.setSignalEvent(downEvent);
        },
        onPointerMove: (PointerMoveEvent moveEvent) {
          gestureNotify.setSignalEvent(moveEvent);
        },
        onPointerUp: (PointerUpEvent upEvent) {
          gestureNotify.setSignalEvent(upEvent);
        },
        onPointerCancel: (PointerCancelEvent cancelEvent) {
          gestureNotify.setSignalEvent(cancelEvent);
        },
        child: scrollableResult,
      ),
    );

    if (keyboardDismissBehavior == ScrollViewKeyboardDismissBehavior.onDrag) {
      return NotificationListener<ScrollUpdateNotification>(
        child: itemResult,
        onNotification: (ScrollUpdateNotification notification) {
          final FocusScopeNode focusScope = FocusScope.of(context);
          if (notification.dragDetails != null && focusScope.hasFocus) {
            focusScope.unfocus();
          }
          return false;
        },
      );
    } else {
      return itemResult;
    }
  }

  @override
  Widget buildViewport(BuildContext context, ViewportOffset offset,
      AxisDirection axisDirection, List<Widget> slivers) {
    assert(() {
      switch (axisDirection) {
        case AxisDirection.up:
        case AxisDirection.down:
          return debugCheckHasDirectionality(
            context,
            why: 'to determine the cross-axis direction of the scroll view',
            hint:
                'Vertical scroll views create Viewport widgets that try to determine their cross axis direction '
                'from the ambient Directionality.',
          );
        case AxisDirection.left:
        case AxisDirection.right:
          return true;
      }
    }());
    if (shrinkWrap) {
      return ShrinkWrappingViewport(
        axisDirection: axisDirection,
        offset: offset,
        slivers: slivers,
        clipBehavior: clipBehavior,
      );
    }

    /// todo：用自定义的方式替换，现在isRepaintBoundary固定为false
    return PowerListViewPort(
      axisDirection: axisDirection,
      offset: offset,
      slivers: slivers,
      cacheExtent: cacheExtent,
      center: center,
      anchor: anchor,
      clipBehavior: clipBehavior,
    );
  }
}
