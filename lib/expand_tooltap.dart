import 'dart:async';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

//View tooltip documentation to understand below variables
typedef TooltipTriggeredCallback = void Function();

class ExpandTooltip extends StatefulWidget {
  const ExpandTooltip({
    super.key,
    required this.height,
    required this.width,
    this.verticalOffset,
    this.preferBelow,
    this.waitDuration,
    this.showDuration,
    this.triggerMode,
    this.enableFeedback,
    this.onTriggered,
    required this.child,
    this.outerDecoration,
  });

  final BoxDecoration? outerDecoration;
  final double height;
  final double width;

  final double? verticalOffset;

  final bool? preferBelow;

  final Widget child;

  final Duration? waitDuration;

  final Duration? showDuration;

  final TooltipTriggerMode? triggerMode;

  final bool? enableFeedback;

  final TooltipTriggeredCallback? onTriggered;

  static final List<ExpandTooltipState> _openedTooltips =
      <ExpandTooltipState>[];

  static void _concealOtherTooltips(ExpandTooltipState current) {
    if (_openedTooltips.isNotEmpty) {
      final List<ExpandTooltipState> openedTooltips = _openedTooltips.toList();
      for (final ExpandTooltipState state in openedTooltips) {
        if (state == current) {
          continue;
        }
        state._concealTooltip();
      }
    }
  }

  static void _revealLastTooltip() {
    if (_openedTooltips.isNotEmpty) {
      _openedTooltips.last._revealTooltip();
    }
  }

  static bool dismissAllToolTips() {
    if (_openedTooltips.isNotEmpty) {
      // Avoid concurrent modification.
      final List<ExpandTooltipState> openedTooltips = _openedTooltips.toList();
      for (final ExpandTooltipState state in openedTooltips) {
        state._dismissTooltip(immediately: true);
      }
      return true;
    }
    return false;
  }

  @override
  State<ExpandTooltip> createState() => ExpandTooltipState();
}

class ExpandTooltipState extends State<ExpandTooltip>
    with SingleTickerProviderStateMixin {
  static const double _defaultVerticalOffset = 24.0;
  static const Duration _fadeInDuration = Duration(milliseconds: 200);
  static const Duration _fadeOutDuration = Duration(milliseconds: 100);
  static const Duration _defaultShowDuration = Duration(milliseconds: 1500);
  static const Duration _defaultHoverShowDuration = Duration(milliseconds: 100);
  static const Duration _defaultWaitDuration = Duration.zero;
  static const TooltipTriggerMode _defaultTriggerMode =
      TooltipTriggerMode.longPress;
  static const bool _defaultEnableFeedback = true;

  late double _verticalOffset;
  late AnimationController _controller;
  late Animation<double> _sizeMultiple;
  OverlayEntry? _entry;
  Timer? _dismissTimer;
  Timer? _showTimer;
  late Duration _showDuration;
  late Duration _hoverShowDuration;
  late Duration _waitDuration;
  late bool _mouseIsConnected;
  bool _pressActivated = false;
  late TooltipTriggerMode _triggerMode;
  late bool _enableFeedback;
  late bool _isConcealed;
  late bool _forceRemoval;
  late bool _visible;

  @override
  void initState() {
    super.initState();
    _isConcealed = false;
    _forceRemoval = false;
    _mouseIsConnected = RendererBinding.instance.mouseTracker.mouseIsConnected;
    _controller = AnimationController(
      duration: _fadeInDuration,
      reverseDuration: _fadeOutDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);
    _sizeMultiple = Tween(begin: 1.0, end: 1.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    RendererBinding.instance.mouseTracker
        .addListener(_handleMouseTrackerChange);

    GestureBinding.instance.pointerRouter.addGlobalRoute(_handlePointerEvent);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _visible = TooltipVisibility.of(context);
  }

  void _handleMouseTrackerChange() {
    if (!mounted) {
      return;
    }
    final bool mouseIsConnected =
        RendererBinding.instance.mouseTracker.mouseIsConnected;
    if (mouseIsConnected != _mouseIsConnected) {
      setState(() {
        _mouseIsConnected = mouseIsConnected;
      });
    }
  }

  void _handleStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.dismissed &&
        (_forceRemoval || !_isConcealed)) {
      _removeEntry();
    }
  }

  void _dismissTooltip({bool immediately = false}) {
    _showTimer?.cancel();
    _showTimer = null;
    if (immediately) {
      _removeEntry();
      return;
    }
    _forceRemoval = true;
    if (_pressActivated) {
      _dismissTimer ??= Timer(_showDuration, _controller.reverse);
    } else {
      _dismissTimer ??= Timer(_hoverShowDuration, _controller.reverse);
    }
    _pressActivated = false;
  }

  void _showTooltip({bool immediately = false}) {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    if (immediately) {
      ensureTooltipVisible();
      return;
    }
    _showTimer ??= Timer(_waitDuration, ensureTooltipVisible);
  }

  void _concealTooltip() {
    if (_isConcealed || _forceRemoval) {
      // Already concealed, or it's being removed.
      return;
    }
    _isConcealed = true;
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _showTimer?.cancel();
    _showTimer = null;
    if (_entry != null) {
      _entry!.remove();
    }
    _controller.reverse();
  }

  void _revealTooltip() {
    if (!_isConcealed) {
      // Already uncovered.
      return;
    }
    _isConcealed = false;
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _showTimer?.cancel();
    _showTimer = null;
    if (!_entry!.mounted) {
      final OverlayState overlayState = Overlay.of(
        context,
        debugRequiredFor: widget,
      );
      overlayState.insert(_entry!);
    }
    SemanticsService.tooltip("Big Item");
    _controller.forward();
  }

  bool ensureTooltipVisible() {
    if (!_visible || !mounted) {
      return false;
    }
    _showTimer?.cancel();
    _showTimer = null;
    _forceRemoval = false;
    if (_isConcealed) {
      if (_mouseIsConnected) {
        ExpandTooltip._concealOtherTooltips(this);
      }
      _revealTooltip();
      return true;
    }
    if (_entry != null) {
      _dismissTimer?.cancel();
      _dismissTimer = null;
      _controller.forward();
      return false;
    }
    _createNewEntry();
    _controller.forward();
    return true;
  }

  static final Set<ExpandTooltipState> _mouseIn = <ExpandTooltipState>{};

  void _handleMouseEnter() {
    if (mounted) {
      _showTooltip();
    }
  }

  void _handleMouseExit({bool immediately = false}) {
    if (mounted) {
      _dismissTooltip(immediately: _isConcealed || immediately);
    }
  }

  void _createNewEntry() {
    final OverlayState overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    );
    final RenderBox box = context.findRenderObject()! as RenderBox;
    final Offset offset = box.localToGlobal(
      box.size.center(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );

    final Widget overlay = Directionality(
      textDirection: Directionality.of(context),
      child: _TooltipOverlay(
        controller: _controller,
        outerDecoration: widget.outerDecoration,
        width: widget.width,
        height: widget.height,
        onEnter: _mouseIsConnected ? (_) => _handleMouseEnter() : null,
        onExit: _mouseIsConnected ? (_) => _handleMouseExit() : null,
        sizeMultiple: _sizeMultiple,
        offset: offset,
        verticalOffset: _verticalOffset,
        child: widget.child,
      ),
    );
    _entry = OverlayEntry(builder: (BuildContext context) => overlay);
    _isConcealed = false;
    overlayState.insert(_entry!);
    SemanticsService.tooltip("Big Item");
    if (_mouseIsConnected) {
      // Hovered tooltips shouldn't show more than one at once. For example, a chip with
      // a delete icon shouldn't show both the delete icon tooltip and the chip tooltip
      // at the same time.
      ExpandTooltip._concealOtherTooltips(this);
    }
    assert(!ExpandTooltip._openedTooltips.contains(this));
    ExpandTooltip._openedTooltips.add(this);
  }

  void _removeEntry() {
    ExpandTooltip._openedTooltips.remove(this);
    _mouseIn.remove(this);
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _showTimer?.cancel();
    _showTimer = null;
    if (!_isConcealed) {
      _entry?.remove();
    }
    _isConcealed = false;
    _entry = null;
    if (_mouseIsConnected) {
      ExpandTooltip._revealLastTooltip();
    }
  }

  void _handlePointerEvent(PointerEvent event) {
    if (_entry == null) {
      return;
    }
    if (event is PointerUpEvent || event is PointerCancelEvent) {
      _handleMouseExit();
    } else if (event is PointerDownEvent) {
      _handleMouseExit(immediately: true);
    }
  }

  @override
  void deactivate() {
    if (_entry != null) {
      _dismissTooltip(immediately: true);
    }
    _showTimer?.cancel();
    super.deactivate();
  }

  @override
  void dispose() {
    GestureBinding.instance.pointerRouter
        .removeGlobalRoute(_handlePointerEvent);
    RendererBinding.instance.mouseTracker
        .removeListener(_handleMouseTrackerChange);
    _removeEntry();
    _controller.dispose();
    super.dispose();
  }

  void _handlePress() {
    _pressActivated = true;
    final bool tooltipCreated = ensureTooltipVisible();
    if (tooltipCreated && _enableFeedback) {
      if (_triggerMode == TooltipTriggerMode.longPress) {
        Feedback.forLongPress(context);
      } else {
        Feedback.forTap(context);
      }
    }
    widget.onTriggered?.call();
  }

  void _handleTap() {
    _handlePress();
    _handleMouseExit();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasOverlay(context));
    final TooltipThemeData tooltipTheme = TooltipTheme.of(context);
    _verticalOffset = widget.verticalOffset ??
        tooltipTheme.verticalOffset ??
        _defaultVerticalOffset;
    _waitDuration = widget.waitDuration ??
        tooltipTheme.waitDuration ??
        _defaultWaitDuration;
    _showDuration = widget.showDuration ??
        tooltipTheme.showDuration ??
        _defaultShowDuration;
    _hoverShowDuration = widget.showDuration ??
        tooltipTheme.showDuration ??
        _defaultHoverShowDuration;
    _triggerMode =
        widget.triggerMode ?? tooltipTheme.triggerMode ?? _defaultTriggerMode;
    _enableFeedback = widget.enableFeedback ??
        tooltipTheme.enableFeedback ??
        _defaultEnableFeedback;

    Widget result = Semantics(
      tooltip: "Big Box",
      child: widget.child,
    );

    // Only check for gestures if tooltip should be visible.
    if (_visible) {
      result = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onLongPress: (_triggerMode == TooltipTriggerMode.longPress)
            ? _handlePress
            : null,
        onTap: (_triggerMode == TooltipTriggerMode.tap) ? _handleTap : null,
        excludeFromSemantics: true,
        child: result,
      );
      // Only check for hovering if there is a mouse connected.
      if (_mouseIsConnected) {
        result = MouseRegion(
          onEnter: (_) => _handleMouseEnter(),
          onExit: (_) => _handleMouseExit(),
          child: result,
        );
      }
    }

    return result;
  }
}

class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  _TooltipPositionDelegate({
    required this.offset,
  });

  final Offset offset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return getBox(
      size: size,
      childSize: childSize,
      target: offset,
    );
  }

  @override
  bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
    return offset != oldDelegate.offset;
  }
}

class _TooltipOverlay extends StatefulWidget {
  const _TooltipOverlay({
    required this.width,
    required this.height,
    required this.sizeMultiple,
    required this.offset,
    required this.verticalOffset,
    this.onEnter,
    this.onExit,
    required this.child,
    required this.outerDecoration,
    required this.controller,
  });

  final Widget child;
  final BoxDecoration? outerDecoration;
  final double height;
  final double width;
  final AnimationController controller;
  final Animation<double> sizeMultiple;
  final Offset offset;
  final double verticalOffset;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;

  @override
  State<_TooltipOverlay> createState() => _TooltipOverlayState();
}

class _TooltipOverlayState extends State<_TooltipOverlay> {
  late double sizeMultiple = widget.sizeMultiple.value;

  @override
  void initState() {
    super.initState();
    widget.sizeMultiple.addListener(() {
      if (!mounted) return;
      setState(() {
        sizeMultiple = widget.sizeMultiple.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Material(
      color: Colors.transparent,
      child: IgnorePointer(
          child: Container(
        decoration: widget.outerDecoration,
        height: widget.height * sizeMultiple,
        width: widget.width * sizeMultiple,
        child: widget.child,
      )),
    );
    if (widget.onEnter != null || widget.onExit != null) {
      result = MouseRegion(
        onEnter: widget.onEnter,
        onExit: widget.onExit,
        child: result,
      );
    }
    return Positioned.fill(
      bottom: MediaQuery.maybeOf(context)?.viewInsets.bottom ?? 0.0,
      child: CustomSingleChildLayout(
        delegate: _TooltipPositionDelegate(
          offset: widget.offset,
        ),
        child: result,
      ),
    );
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      widget.controller.reset();
    });
    super.dispose();
  }
}

Offset getBox({
  required Size size,
  required Size childSize,
  required Offset target,
  double margin = 10.0,
}) {
  double y;
  y = target.dy - childSize.height * 0.5;

  // HORIZONTAL DIRECTION
  double x;
  if (size.width - margin * 2.0 < childSize.width) {
    x = (size.width - childSize.width) / 2.0;
  } else {
    final double normalizedTargetX =
        clampDouble(target.dx, margin, size.width - margin);
    final double edge = margin + childSize.width / 2.0;
    if (normalizedTargetX < edge) {
      x = margin;
    } else if (normalizedTargetX > size.width - edge) {
      x = size.width - margin - childSize.width;
    } else {
      x = normalizedTargetX - childSize.width / 2.0;
    }
  }
  return Offset(x, y);
}
