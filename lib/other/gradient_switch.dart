import 'package:flutter/material.dart';

// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// FLutter version 1.24.0-10.2.pre

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

const double _kTrackHeight = 14.0;
const double _kTrackWidth = 33.0;
const double _kTrackRadius = _kTrackHeight / 2.0;
const double _kThumbRadius = 10.0;
const double _kSwitchMinSize = kMinInteractiveDimension - 8.0;
const double _kSwitchWidth = _kTrackWidth - 2 * _kTrackRadius + _kSwitchMinSize;
const double _kSwitchHeight = _kSwitchMinSize + 8.0;
const double _kSwitchHeightCollapsed = _kSwitchMinSize;

enum _SwitchType { material, adaptive }

/// A material design switch.
///
/// Used to toggle the on/off state of a single setting.
///
/// The switch itself does not maintain any state. Instead, when the state of
/// the switch changes, the widget calls the [onChanged] callback. Most widgets
/// that use a switch will listen for the [onChanged] callback and rebuild the
/// switch with a new [value] to update the visual appearance of the switch.
///
/// If the [onChanged] callback is null, then the switch will be disabled (it
/// will not respond to input). A disabled switch's thumb and track are rendered
/// in shades of grey by default. The default appearance of a disabled switch
/// can be overridden with [inactiveThumbColor] and [inactiveTrackColor].
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
///  * [SwitchListTile], which combines this widget with a [ListTile] so that
///    you can give the switch a label.
///  * [Checkbox], another widget with similar semantics.
///  * [Radio], for selecting among a set of explicit values.
///  * [Slider], for selecting a value in a range.
///  * <https://material.io/design/components/selection-controls.html#switches>
class GradientSwitch extends StatefulWidget {
  /// Creates a material design switch.
  ///
  /// The switch itself does not maintain any state. Instead, when the state of
  /// the switch changes, the widget calls the [onChanged] callback. Most widgets
  /// that use a switch will listen for the [onChanged] callback and rebuild the
  /// switch with a new [value] to update the visual appearance of the switch.
  ///
  /// The following arguments are required:
  ///
  /// * [value] determines whether this switch is on or off.
  /// * [onChanged] is called when the user toggles the switch on or off.
  const GradientSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.gradient,
    this.activeColor = Colors.white,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.focusNode,
    this.autofocus = false,
  })  : _switchType = _SwitchType.material,
        assert(dragStartBehavior != null),
        assert(activeThumbImage != null || onActiveThumbImageError == null),
        assert(inactiveThumbImage != null || onInactiveThumbImageError == null),
        super(key: key);

  /// Creates an adaptive [GradientSwitch] based on whether the target platform is iOS
  /// or macOS, following Material design's
  /// [Cross-platform guidelines](https://material.io/design/platform-guidance/cross-platform-adaptation.html).
  ///
  /// On iOS and macOS, this constructor creates a [CupertinoSwitch], which has
  /// matching functionality and presentation as Material switches, and are the
  /// graphics expected on iOS. On other platforms, this creates a Material
  /// design [GradientSwitch].
  ///
  /// If a [CupertinoSwitch] is created, the following parameters are ignored:
  /// [activeTrackColor], [inactiveThumbColor], [inactiveTrackColor],
  /// [activeThumbImage], [onActiveThumbImageError], [inactiveThumbImage],
  /// [onInactiveThumbImageError], [materialTapTargetSize].
  ///
  /// The target platform is based on the current [Theme]: [ThemeData.platform].
  const GradientSwitch.adaptive({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.gradient,
    this.activeColor = Colors.white,
    this.activeTrackColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeThumbImage,
    this.onActiveThumbImageError,
    this.inactiveThumbImage,
    this.onInactiveThumbImageError,
    this.materialTapTargetSize,
    this.dragStartBehavior = DragStartBehavior.start,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.splashRadius,
    this.focusNode,
    this.autofocus = false,
  })  : assert(autofocus != null),
        assert(activeThumbImage != null || onActiveThumbImageError == null),
        assert(inactiveThumbImage != null || onInactiveThumbImageError == null),
        _switchType = _SwitchType.adaptive,
        super(key: key);

  /// The gradient color when it is active
  final Gradient gradient;

  /// Whether this switch is on or off.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// Switch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool>? onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color activeColor;

  /// The color to use on the track when this switch is on.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor] with the opacity set at 50%.
  ///
  /// Ignored if this switch is created with [GradientSwitch.adaptive].
  final Color? activeTrackColor;

  /// The color to use on the thumb when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [GradientSwitch.adaptive].
  final Color? inactiveThumbColor;

  /// The color to use on the track when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [GradientSwitch.adaptive].
  final Color? inactiveTrackColor;

  /// An image to use on the thumb of this switch when the switch is on.
  ///
  /// Ignored if this switch is created with [GradientSwitch.adaptive].
  final ImageProvider? activeThumbImage;

  /// An optional error callback for errors emitted when loading
  /// [activeThumbImage].
  final ImageErrorListener? onActiveThumbImageError;

  /// An image to use on the thumb of this switch when the switch is off.
  ///
  /// Ignored if this switch is created with [GradientSwitch.adaptive].
  final ImageProvider? inactiveThumbImage;

  /// An optional error callback for errors emitted when loading
  /// [inactiveThumbImage].
  final ImageErrorListener? onInactiveThumbImageError;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  final _SwitchType _switchType;

  /// {@macro flutter.cupertino.CupertinoSwitch.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// The color for the button's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the button's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// The splash radius of the circular [Material] ink response.
  ///
  /// If null, then [kRadialReactionRadius] is used.
  final double? splashRadius;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  @override
  _GradientSwitchState createState() => _GradientSwitchState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('value',
        value: value, ifTrue: 'on', ifFalse: 'off', showName: true));
    properties.add(ObjectFlagProperty<ValueChanged<bool>>(
        'onChanged', onChanged,
        ifNull: 'disabled'));
  }
}

class _GradientSwitchState extends State<GradientSwitch>
    with TickerProviderStateMixin {
  late Map<Type, Action<Intent>> _actionMap;

  @override
  void initState() {
    super.initState();
    _actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: _actionHandler),
    };
  }

  void _actionHandler(ActivateIntent intent) {
    if (widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
    final RenderObject renderObject = context.findRenderObject()!;
    renderObject.sendSemanticsEvent(const TapSemanticEvent());
  }

  bool _focused = false;
  void _handleFocusHighlightChanged(bool focused) {
    if (focused != _focused) {
      setState(() {
        _focused = focused;
      });
    }
  }

  bool _hovering = false;
  void _handleHoverChanged(bool hovering) {
    if (hovering != _hovering) {
      setState(() {
        _hovering = hovering;
      });
    }
  }

  Size getSwitchSize(ThemeData theme) {
    switch (widget.materialTapTargetSize ?? theme.materialTapTargetSize) {
      case MaterialTapTargetSize.padded:
        return const Size(_kSwitchWidth, _kSwitchHeight);
      case MaterialTapTargetSize.shrinkWrap:
        return const Size(_kSwitchWidth, _kSwitchHeightCollapsed);
    }
  }

  bool get enabled => widget.onChanged != null;

  void _didFinishDragging() {
    // The user has finished dragging the thumb of this switch. Rebuild the switch
    // to update the animation.
    setState(() {});
  }

  Widget buildMaterialSwitch(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    final Color activeThumbColor = widget.activeColor;
    final Color activeTrackColor =
        widget.activeTrackColor ?? activeThumbColor.withAlpha(0x80);
    final Color hoverColor = widget.hoverColor ?? theme.hoverColor;
    final Color focusColor = widget.focusColor ?? theme.focusColor;

    final Color inactiveThumbColor;
    final Color inactiveTrackColor;
    if (enabled) {
      const Color black32 = Color(0x52000000); // Black with 32% opacity
      inactiveThumbColor = widget.inactiveThumbColor ??
          (isDark ? Colors.grey.shade400 : Colors.grey.shade50);
      inactiveTrackColor =
          widget.inactiveTrackColor ?? (isDark ? Colors.white30 : black32);
    } else {
      inactiveThumbColor = widget.inactiveThumbColor ??
          (isDark ? Colors.grey.shade800 : Colors.grey.shade400);
      inactiveTrackColor = widget.inactiveTrackColor ??
          (isDark ? Colors.white10 : Colors.black12);
    }
    final MouseCursor effectiveMouseCursor =
        MaterialStateProperty.resolveAs<MouseCursor>(
      widget.mouseCursor ?? MaterialStateMouseCursor.clickable,
      <MaterialState>{
        if (!enabled) MaterialState.disabled,
        if (_hovering) MaterialState.hovered,
        if (_focused) MaterialState.focused,
        if (widget.value) MaterialState.selected,
      },
    );

    return FocusableActionDetector(
      actions: _actionMap,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: enabled,
      onShowFocusHighlight: _handleFocusHighlightChanged,
      onShowHoverHighlight: _handleHoverChanged,
      mouseCursor: effectiveMouseCursor,
      child: Builder(
        builder: (BuildContext context) {
          return _SwitchRenderObjectWidget(
            dragStartBehavior: widget.dragStartBehavior,
            value: widget.value,
            activeColor: activeThumbColor,
            inactiveColor: inactiveThumbColor,
            hoverColor: hoverColor,
            focusColor: focusColor,
            splashRadius: widget.splashRadius ?? kRadialReactionRadius,
            activeThumbImage: widget.activeThumbImage,
            onActiveThumbImageError: widget.onActiveThumbImageError,
            inactiveThumbImage: widget.inactiveThumbImage,
            onInactiveThumbImageError: widget.onInactiveThumbImageError,
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            configuration: createLocalImageConfiguration(context),
            onChanged: widget.onChanged,
            additionalConstraints: BoxConstraints.tight(getSwitchSize(theme)),
            hasFocus: _focused,
            hovering: _hovering,
            state: this,
            gradient: widget.gradient,
          );
        },
      ),
    );
  }

  Widget buildCupertinoSwitch(BuildContext context) {
    final Size size = getSwitchSize(Theme.of(context));
    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      child: Container(
        width: size.width, // Same size as the Material switch.
        height: size.height,
        alignment: Alignment.center,
        child: CupertinoSwitch(
            dragStartBehavior: widget.dragStartBehavior,
            value: widget.value,
            onChanged: widget.onChanged,
            activeColor: widget.activeColor,
            trackColor: widget.inactiveTrackColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget._switchType) {
      case _SwitchType.material:
        return buildMaterialSwitch(context);

      case _SwitchType.adaptive:
        {
          final ThemeData theme = Theme.of(context);
          assert(theme.platform != null);
          switch (theme.platform) {
            case TargetPlatform.android:
            case TargetPlatform.fuchsia:
            case TargetPlatform.linux:
            case TargetPlatform.windows:
              return buildMaterialSwitch(context);
            case TargetPlatform.iOS:
            case TargetPlatform.macOS:
              return buildCupertinoSwitch(context);
          }
        }
    }
  }
}

class _SwitchRenderObjectWidget extends LeafRenderObjectWidget {
  const _SwitchRenderObjectWidget({
    Key? key,
    required this.gradient,
    required this.value,
    required this.activeColor,
    required this.inactiveColor,
    required this.hoverColor,
    required this.focusColor,
    required this.splashRadius,
    required this.activeThumbImage,
    required this.onActiveThumbImageError,
    required this.inactiveThumbImage,
    required this.onInactiveThumbImageError,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.configuration,
    required this.onChanged,
    required this.additionalConstraints,
    required this.dragStartBehavior,
    required this.hasFocus,
    required this.hovering,
    required this.state,
  }) : super(key: key);

  final bool value;
  final Gradient gradient;
  final Color activeColor;
  final Color inactiveColor;
  final Color hoverColor;
  final Color focusColor;
  final double splashRadius;
  final ImageProvider? activeThumbImage;
  final ImageErrorListener? onActiveThumbImageError;
  final ImageProvider? inactiveThumbImage;
  final ImageErrorListener? onInactiveThumbImageError;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final ImageConfiguration configuration;
  final ValueChanged<bool>? onChanged;
  final BoxConstraints additionalConstraints;
  final DragStartBehavior dragStartBehavior;
  final bool hasFocus;
  final bool hovering;
  final _GradientSwitchState state;

  @override
  _RenderSwitch createRenderObject(BuildContext context) {
    return _RenderSwitch(
      dragStartBehavior: dragStartBehavior,
      value: value,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      hoverColor: hoverColor,
      focusColor: focusColor,
      splashRadius: splashRadius,
      activeThumbImage: activeThumbImage,
      onActiveThumbImageError: onActiveThumbImageError,
      inactiveThumbImage: inactiveThumbImage,
      onInactiveThumbImageError: onInactiveThumbImageError,
      activeTrackColor: activeTrackColor,
      inactiveTrackColor: inactiveTrackColor,
      configuration: configuration,
      onChanged: onChanged != null ? _handleValueChanged : null,
      textDirection: Directionality.of(context),
      additionalConstraints: additionalConstraints,
      hasFocus: hasFocus,
      hovering: hovering,
      state: state,
      gradient: gradient,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderSwitch renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor
      ..hoverColor = hoverColor
      ..focusColor = focusColor
      ..splashRadius = splashRadius
      ..activeThumbImage = activeThumbImage
      ..onActiveThumbImageError = onActiveThumbImageError
      ..inactiveThumbImage = inactiveThumbImage
      ..onInactiveThumbImageError = onInactiveThumbImageError
      ..activeTrackColor = activeTrackColor
      ..inactiveTrackColor = inactiveTrackColor
      ..configuration = configuration
      ..onChanged = onChanged != null ? _handleValueChanged : null
      ..textDirection = Directionality.of(context)
      ..additionalConstraints = additionalConstraints
      ..dragStartBehavior = dragStartBehavior
      ..hasFocus = hasFocus
      ..hovering = hovering
      ..vsync = state;
  }

  void _handleValueChanged(bool? value) {
    // Wrap the onChanged callback because the RenderToggleable supports tri-state
    // values (i.e. value can be null), but the Switch doesn't. We pass false
    // for the tristate param to RenderToggleable, so value should never
    // be null.
    assert(value != null);
    if (onChanged != null) {
      onChanged!(value!);
    }
  }
}

class _RenderSwitch extends RenderToggleable {
  _RenderSwitch({
    required this.gradient,
    required bool value,
    required Color activeColor,
    required Color inactiveColor,
    required Color hoverColor,
    required Color focusColor,
    required double splashRadius,
    required ImageProvider? activeThumbImage,
    required ImageErrorListener? onActiveThumbImageError,
    required ImageProvider? inactiveThumbImage,
    required ImageErrorListener? onInactiveThumbImageError,
    required Color activeTrackColor,
    required Color inactiveTrackColor,
    required ImageConfiguration configuration,
    required BoxConstraints additionalConstraints,
    required TextDirection textDirection,
    required ValueChanged<bool?>? onChanged,
    required DragStartBehavior dragStartBehavior,
    required bool hasFocus,
    required bool hovering,
    required this.state,
  })   : assert(textDirection != null),
        _activeThumbImage = activeThumbImage,
        _onActiveThumbImageError = onActiveThumbImageError,
        _inactiveThumbImage = inactiveThumbImage,
        _onInactiveThumbImageError = onInactiveThumbImageError,
        _activeTrackColor = activeTrackColor,
        _inactiveTrackColor = inactiveTrackColor,
        _configuration = configuration,
        _textDirection = textDirection,
        super(
          value: value,
          tristate: false,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          hoverColor: hoverColor,
          focusColor: focusColor,
          splashRadius: splashRadius,
          onChanged: onChanged,
          additionalConstraints: additionalConstraints,
          hasFocus: hasFocus,
          hovering: hovering,
          vsync: state,
        ) {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..dragStartBehavior = dragStartBehavior;
  }

  /// The gradient when active
  final Gradient gradient;

  ImageProvider? get activeThumbImage => _activeThumbImage;
  ImageProvider? _activeThumbImage;
  set activeThumbImage(ImageProvider? value) {
    if (value == _activeThumbImage) return;
    _activeThumbImage = value;
    markNeedsPaint();
  }

  ImageErrorListener? get onActiveThumbImageError => _onActiveThumbImageError;
  ImageErrorListener? _onActiveThumbImageError;
  set onActiveThumbImageError(ImageErrorListener? value) {
    if (value == _onActiveThumbImageError) {
      return;
    }
    _onActiveThumbImageError = value;
    markNeedsPaint();
  }

  ImageProvider? get inactiveThumbImage => _inactiveThumbImage;
  ImageProvider? _inactiveThumbImage;
  set inactiveThumbImage(ImageProvider? value) {
    if (value == _inactiveThumbImage) return;
    _inactiveThumbImage = value;
    markNeedsPaint();
  }

  ImageErrorListener? get onInactiveThumbImageError =>
      _onInactiveThumbImageError;
  ImageErrorListener? _onInactiveThumbImageError;
  set onInactiveThumbImageError(ImageErrorListener? value) {
    if (value == _onInactiveThumbImageError) {
      return;
    }
    _onInactiveThumbImageError = value;
    markNeedsPaint();
  }

  Color get activeTrackColor => _activeTrackColor;
  Color _activeTrackColor;
  set activeTrackColor(Color value) {
    assert(value != null);
    if (value == _activeTrackColor) return;
    _activeTrackColor = value;
    markNeedsPaint();
  }

  Color get inactiveTrackColor => _inactiveTrackColor;
  Color _inactiveTrackColor;
  set inactiveTrackColor(Color value) {
    assert(value != null);
    if (value == _inactiveTrackColor) return;
    _inactiveTrackColor = value;
    markNeedsPaint();
  }

  ImageConfiguration get configuration => _configuration;
  ImageConfiguration _configuration;
  set configuration(ImageConfiguration value) {
    assert(value != null);
    if (value == _configuration) return;
    _configuration = value;
    markNeedsPaint();
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    assert(value != null);
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsPaint();
  }

  DragStartBehavior get dragStartBehavior => _drag.dragStartBehavior;
  set dragStartBehavior(DragStartBehavior value) {
    assert(value != null);
    if (_drag.dragStartBehavior == value) return;
    _drag.dragStartBehavior = value;
  }

  _GradientSwitchState state;

  @override
  set value(bool? newValue) {
    assert(value != null);
    super.value = newValue;
    // The widget is rebuilt and we have pending position animation to play.
    if (_needsPositionAnimation) {
      _needsPositionAnimation = false;
      position.reverseCurve = null;
      if (newValue!)
        positionController.forward();
      else
        positionController.reverse();
    }
  }

  @override
  void detach() {
    _cachedThumbPainter?.dispose();
    _cachedThumbPainter = null;
    super.detach();
  }

  double get _trackInnerLength => size.width - _kSwitchMinSize;

  late HorizontalDragGestureRecognizer _drag;

  bool _needsPositionAnimation = false;

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) reactionController.forward();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      position.reverseCurve = null;
      final double delta = details.primaryDelta! / _trackInnerLength;
      switch (textDirection) {
        case TextDirection.rtl:
          positionController.value -= delta;
          break;
        case TextDirection.ltr:
          positionController.value += delta;
          break;
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    _needsPositionAnimation = true;

    if (position.value >= 0.5 != value) onChanged!(!value!);
    reactionController.reverse();
    state._didFinishDragging();
  }

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent && onChanged != null) _drag.addPointer(event);
    super.handleEvent(event, entry);
  }

  Color? _cachedThumbColor;
  ImageProvider? _cachedThumbImage;
  ImageErrorListener? _cachedThumbErrorListener;
  BoxPainter? _cachedThumbPainter;

  BoxDecoration _createDefaultThumbDecoration(
      Color color, ImageProvider? image, ImageErrorListener? errorListener) {
    return BoxDecoration(
      color: color,
      image: image == null
          ? null
          : DecorationImage(image: image, onError: errorListener),
      shape: BoxShape.circle,
      boxShadow: kElevationToShadow[1],
    );
  }

  bool _isPainting = false;

  void _handleDecorationChanged() {
    // If the image decoration is available synchronously, we'll get called here
    // during paint. There's no reason to mark ourselves as needing paint if we
    // are already in the middle of painting. (In fact, doing so would trigger
    // an assert).
    if (!_isPainting) markNeedsPaint();
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isToggled = value == true;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;
    final bool isEnabled = onChanged != null;
    final double currentValue = position.value;

    final double visualPosition;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - currentValue;
        break;
      case TextDirection.ltr:
        visualPosition = currentValue;
        break;
    }

    // ignore: invalid_use_of_protected_member
    final Gradient grad = gradient.lerpFrom(
        LinearGradient(colors: [inactiveTrackColor, inactiveTrackColor]),
        currentValue)!;

    // the top level gradient that only goes till the start of the thumb
    final Gradient topGrad = gradient.lerpFrom(
        LinearGradient(colors: [Colors.transparent, Colors.transparent]),
        currentValue)!;

    final Color thumbColor = isEnabled
        ? Color.lerp(inactiveColor, activeColor, currentValue)!
        : inactiveColor;

    final ImageProvider? thumbImage = isEnabled
        ? (currentValue < 0.5 ? inactiveThumbImage : activeThumbImage)
        : inactiveThumbImage;

    final ImageErrorListener? thumbErrorListener = isEnabled
        ? (currentValue < 0.5
            ? onInactiveThumbImageError
            : onActiveThumbImageError)
        : onInactiveThumbImageError;

    // Paint the track
    // final Paint paint = Paint()..color = trackColor;
    const double trackHorizontalPadding = kRadialReactionRadius - _kTrackRadius;
    final Rect trackRect = Rect.fromLTWH(
      offset.dx + trackHorizontalPadding,
      offset.dy + (size.height - _kTrackHeight) / 2.0,
      size.width - 2.0 * trackHorizontalPadding,
      _kTrackHeight,
    );

    final Rect gradientRect = Rect.fromLTWH(
      offset.dx + trackHorizontalPadding,
      offset.dy + (size.height - _kTrackHeight) / 2.0,
      (size.width - 2.0 * trackHorizontalPadding) - (_kThumbRadius * 1.2),
      _kTrackHeight,
    );

    final Paint bottomPaint = Paint()..shader = grad.createShader(trackRect);
    final Paint gradientPaint = Paint()
      ..shader = topGrad.createShader(gradientRect);

    final RRect trackRRect = RRect.fromRectAndRadius(
        trackRect, const Radius.circular(_kTrackRadius));
    canvas.drawRRect(trackRRect, bottomPaint);

    final RRect gradientRRect = RRect.fromRectAndRadius(
        gradientRect, const Radius.circular(_kTrackRadius));
    canvas.drawRRect(gradientRRect, gradientPaint);

    final Offset thumbPosition = Offset(
      kRadialReactionRadius + visualPosition * _trackInnerLength,
      size.height / 2.0,
    );

    paintRadialReaction(canvas, offset, thumbPosition);

    try {
      _isPainting = true;
      if (_cachedThumbPainter == null ||
          thumbColor != _cachedThumbColor ||
          thumbImage != _cachedThumbImage ||
          thumbErrorListener != _cachedThumbErrorListener) {
        _cachedThumbColor = thumbColor;
        _cachedThumbImage = thumbImage;
        _cachedThumbErrorListener = thumbErrorListener;
        _cachedThumbPainter = _createDefaultThumbDecoration(
                thumbColor, thumbImage, thumbErrorListener)
            .createBoxPainter(_handleDecorationChanged);
      }
      final BoxPainter thumbPainter = _cachedThumbPainter!;

      // The thumb contracts slightly during the animation
      final double inset = 1.0 - (currentValue - 0.5).abs() * 2.0;
      final double radius = _kThumbRadius - inset;
      thumbPainter.paint(
        canvas,
        thumbPosition + offset - Offset(radius, radius),
        configuration.copyWith(size: Size.fromRadius(radius)),
      );
    } finally {
      _isPainting = false;
    }
  }
}
