import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../power_list/controller/power_list_scroll_controller.dart';
import '../activity/power_list_scroll_activity.dart';

class PowerListScrollSimulationController
    extends PowerListPageScrollController {
  final double? tolerance; // 动画结尾震动公差

  final double? minStartDragDelta; // 短时拖动超过一定范围才触发翻页动画

  final int? startAnimationMillseconds; // 开始动画的执行时间

  final Curve? startAnimationEffect;

  final double? minDragStopDistance; // 小于一定范围才允许stop 修复问题2

  PowerListScrollSimulationController({
    int initialPage = 0,
    bool keepPage = true,
    double viewportFraction = 1.0,
    bool isLoop = false,
    this.tolerance,
    this.minStartDragDelta,
    this.startAnimationMillseconds,
    this.startAnimationEffect,
    this.minDragStopDistance,
  }) : super(
          initialPage: initialPage,
          keepPage: keepPage,
          viewportFraction: viewportFraction,
          isLoop: isLoop,
        );

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics,
      ScrollContext context, ScrollPosition? oldPosition) {
    return PowerListScrollSimulationPosition(
      physics: physics,
      context: context,
      isLoop: isLoop,
      initialPage: initialPage,
      keepPage: keepPage,
      oldPosition: oldPosition,
      viewportFraction: viewportFraction,
      tolerance: tolerance,
      minStartDragDelta: minStartDragDelta,
      startAnimationMillseconds: startAnimationMillseconds,
      startAnimationEffect: startAnimationEffect,
      minDragStopDistance: minDragStopDistance,
    );
  }
}

class PowerListScrollSimulationPosition extends PowerListPagePosition {
  double? tolerance; // 动画结尾震动公差

  double? minStartDragDelta; // 短时拖动超过一定范围才触发翻页动画

  int? startAnimationMillseconds; // 开始动画的执行时间

  Curve? startAnimationEffect;

  double? minDragStopDistance; // 小于一定范围才允许stop 修复问题2

  /// Create a [ScrollPosition] object that manages its behavior using
  /// [ScrollActivity] objects.
  ///
  /// The `initialPixels` argument can be null, but in that case it is
  /// imperative that the value be set, using [correctPixels], as soon as
  /// [applyNewDimensions] is invoked, before calling the inherited
  /// implementation of that method.
  ///
  /// If [keepScrollOffset] is true (the default), the current scroll offset is
  /// saved with [PageStorage] and restored it if this scroll position's scrollable
  /// is recreated.
  PowerListScrollSimulationPosition({
    required ScrollPhysics physics,
    required ScrollContext context,
    int initialPage = 0,
    bool isLoop = false,
    bool keepPage = true,
    double viewportFraction = 1.0,
    ScrollPosition? oldPosition,
    this.tolerance,
    this.minStartDragDelta,
    this.startAnimationMillseconds,
    this.startAnimationEffect,
    this.minDragStopDistance,
  }) : super(
          physics: physics,
          context: context,
          initialPage: initialPage,
          isLoop: isLoop,
          oldPosition: oldPosition,
          keepPage: keepPage,
          viewportFraction: viewportFraction,
        );

  @override
  Drag drag(DragStartDetails details, VoidCallback dragCancelCallback) {
    final PowerListSimulationScrollDragController drag =
        PowerListSimulationScrollDragController(
      delegate: this,
      details: details,
      onDragCanceled: dragCancelCallback,
      carriedVelocity: physics.carriedMomentum(heldPreviousVelocity),
      motionStartDistanceThreshold: physics.dragStartDistanceMotionThreshold,
      vsync: context.vsync,
      minStartDragDelta: minStartDragDelta,
      startAnimationEffect: startAnimationEffect,
      startAnimationMillseconds: startAnimationMillseconds,
      minDragStopDistance: minDragStopDistance,
    );
    beginActivity(PowerListSimulationDragScrollActivity(this, drag));
    assert(currentDrag == null);
    currentDrag = drag;
    return drag;
  }

  @override
  void goBallistic(double velocity) {
    assert(hasPixels);
    final Simulation? simulation =
        physics.createBallisticSimulation(this, velocity);
    if (simulation != null) {
      simulation.tolerance = Tolerance(
          distance: tolerance ?? 100,
          time: tolerance ?? 100,
          velocity: tolerance ?? 100); // 修复了问题3 结尾0斗争的问题 todo 回头抽出来可配置
      beginActivity(
          PowerListBallisticScrollActivity(this, simulation, context.vsync));
    } else {
      goIdle();
    }
  }
}
