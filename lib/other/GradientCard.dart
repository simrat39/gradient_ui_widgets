import 'package:flutter/material.dart';

class GradientCard extends Card {
  /// Creates a material design card.
  ///
  /// The [elevation] must be null or non-negative. The [borderOnForeground]
  /// must not be null.
  GradientCard({
    Key? key,
    Color? color,
    required Gradient gradient,
    Color? shadowColor,
    double? elevation,
    ShapeBorder? shape,
    bool borderOnForeground = true,
    EdgeInsets? margin,
    EdgeInsets padding = const EdgeInsets.all(8.0),
    Clip? clipBehavior,
    Widget? child,
    bool semanticContainer = true,
  })  : assert(elevation == null || elevation >= 0.0),
        super(
          key: key,
          color: color,
          shadowColor: shadowColor,
          elevation: elevation,
          shape: shape,
          borderOnForeground: borderOnForeground,
          margin: margin,
          clipBehavior: clipBehavior,
          child: Ink(
            padding: padding,
            decoration: ShapeDecoration(
              shape: shape ??
                  ThemeData().cardTheme.shape ??
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
              gradient: gradient,
            ),
            child: child,
          ),
          semanticContainer: semanticContainer,
        );
}
