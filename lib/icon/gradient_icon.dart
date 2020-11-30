import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color color = Colors.white;
  final Gradient gradient;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const GradientIcon(
    this.icon, {
    Key? key,
    this.size,
    this.semanticLabel,
    this.textDirection,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Icon(
        icon,
        size: size,
        color: color,
        semanticLabel: semanticLabel,
        textDirection: textDirection,
        key: key,
      ),
    );
  }
}
