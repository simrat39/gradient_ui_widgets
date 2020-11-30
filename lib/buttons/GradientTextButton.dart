import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class GradientTextButton extends TextButton {
  /// Create a TextButton.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  GradientTextButton({
    Key? key,
    required VoidCallback? onPressed,
    Color? splashColor,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    required Gradient gradient,
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8),
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: style ??
              ButtonStyle(
                  overlayColor: ButtonStyleButton.allOrNull(splashColor ??
                      gradient.colors.elementAt(0).withOpacity(0.1))),
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: Padding(
            padding: style?.padding != null ? EdgeInsets.zero : padding,
            child: ShaderMask(
              shaderCallback: (Rect bounds) => gradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              blendMode: BlendMode.srcIn,
              child: child,
            ),
          ),
        );

  /// Create a text button from a pair of widgets that serve as the button's
  /// [icon] and [label].
  ///
  /// The icon and label are arranged in a row and padded by 8 logical pixels
  /// at the ends, with an 8 pixel gap in between.
  ///
  /// The [icon] and [label] arguments must not be null.
  factory GradientTextButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    required Gradient gradient,
    required Widget icon,
    required Widget label,
  }) = _GradientTextButtonWithIcon;
}

class _GradientTextButtonWithIcon extends GradientTextButton {
  _GradientTextButtonWithIcon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
    required Gradient gradient,
    Clip? clipBehavior,
    required Widget icon,
    required Widget label,
  }) : super(
          key: key,
          onPressed: onPressed,
          gradient: gradient,
          padding: padding,
          onLongPress: onLongPress,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _GradientTextButtonWithIconChild(icon: icon, label: label),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.all(8),
      const EdgeInsets.symmetric(horizontal: 4),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
    return super.defaultStyleOf(context).copyWith(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(scaledPadding));
  }
}

class _GradientTextButtonWithIconChild extends StatelessWidget {
  const _GradientTextButtonWithIconChild({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), label],
    );
  }
}
