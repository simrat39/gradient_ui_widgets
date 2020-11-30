import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GradientSelectableText extends StatelessWidget {
  const GradientSelectableText(
    String this.data, {
    required this.gradient,
    Key? key,
    this.focusNode,
    this.style = const TextStyle(color: Colors.white),
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.showCursor = false,
    this.autofocus = false,
    ToolbarOptions? toolbarOptions,
    this.minLines,
    this.maxLines,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.scrollPhysics,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
  })  : assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          'minLines can\'t be greater than maxLines',
        ),
        textSpan = null,
        toolbarOptions = toolbarOptions ??
            const ToolbarOptions(
              selectAll: true,
              copy: true,
            ),
        super(key: key);

  const GradientSelectableText.rich(
    TextSpan this.textSpan, {
    required this.gradient,
    Key? key,
    this.focusNode,
    this.style = const TextStyle(color: Colors.white),
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaleFactor,
    this.showCursor = false,
    this.autofocus = false,
    ToolbarOptions? toolbarOptions,
    this.minLines,
    this.maxLines,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.dragStartBehavior = DragStartBehavior.start,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.onTap,
    this.scrollPhysics,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
  })  : assert(maxLines == null || maxLines > 0),
        assert(minLines == null || minLines > 0),
        assert(
          (maxLines == null) || (minLines == null) || (maxLines >= minLines),
          'minLines can\'t be greater than maxLines',
        ),
        data = null,
        toolbarOptions = toolbarOptions ??
            const ToolbarOptions(
              selectAll: true,
              copy: true,
            ),
        super(key: key);

  final String? data;
  final TextSpan? textSpan;
  final FocusNode? focusNode;
  final TextStyle style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final double? textScaleFactor;
  final bool autofocus;
  final int? minLines;
  final int? maxLines;
  final bool showCursor;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final DragStartBehavior dragStartBehavior;
  final ToolbarOptions toolbarOptions;
  bool get selectionEnabled => enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final ScrollPhysics? scrollPhysics;
  final TextHeightBehavior? textHeightBehavior;
  final TextWidthBasis? textWidthBasis;
  final SelectionChangedCallback? onSelectionChanged;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: data == null
          ? SelectableText.rich(
              textSpan!,
              key: key,
              focusNode: focusNode,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textDirection: textDirection,
              textScaleFactor: textScaleFactor,
              autofocus: autofocus,
              minLines: minLines,
              maxLines: maxLines,
              showCursor: showCursor,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              enableInteractiveSelection: enableInteractiveSelection,
              selectionControls: selectionControls,
              dragStartBehavior: dragStartBehavior,
              toolbarOptions: toolbarOptions,
              onTap: onTap,
              scrollPhysics: scrollPhysics,
              textHeightBehavior: textHeightBehavior,
              textWidthBasis: textWidthBasis,
              onSelectionChanged: onSelectionChanged,
            )
          : SelectableText(
              data!,
              key: key,
              focusNode: focusNode,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textDirection: textDirection,
              textScaleFactor: textScaleFactor,
              autofocus: autofocus,
              minLines: minLines,
              maxLines: maxLines,
              showCursor: showCursor,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              enableInteractiveSelection: enableInteractiveSelection,
              selectionControls: selectionControls,
              dragStartBehavior: dragStartBehavior,
              toolbarOptions: toolbarOptions,
              onTap: onTap,
              scrollPhysics: scrollPhysics,
              textHeightBehavior: textHeightBehavior,
              textWidthBasis: textWidthBasis,
              onSelectionChanged: onSelectionChanged,
            ),
    );
  }
}
