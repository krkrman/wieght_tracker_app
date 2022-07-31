import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final Color color, backgroundColor;
  final double fontSize;
  final String text;
  final FontWeight fontWeight;
  final Alignment alignment;
  final TextStyle? style;
  final int? maxLines;
  final EdgeInsets? padding;
  final double? width, height;
  final TextAlign textAlign;
  final GestureTapCallback? onPressed;

  /// put a line through the text as in discount
  final bool isLineThrough, isUnderLine;

  const CustomText(
      {this.backgroundColor = Colors.transparent,
      this.color = Colors.black,
      this.alignment = Alignment.centerLeft,
      this.fontSize = 20,
      required this.text,
      this.fontWeight = FontWeight.normal,
      this.style,
      this.maxLines = 50,
      this.padding,
      this.isLineThrough = false,
      this.isUnderLine = false,
      this.width,
      this.height,
      this.onPressed,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: alignment,
        color: backgroundColor,
        width: width,
        height: height,
        padding: padding,
        child: Text(
          text,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          style: style ??
              TextStyle(
                color: color,
                fontSize: fontSize,
                fontWeight: fontWeight,
                decoration: isLineThrough
                    ? TextDecoration.lineThrough
                    : isUnderLine
                        ? TextDecoration.underline
                        : TextDecoration.none,
              ),
        ),
      ),
    );
  }
}
