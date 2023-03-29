import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  final GlobalKey? textKey;
  final String text;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final Color? color;
  final double fontSize;
  final double? lineHeight;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Function()? onTap;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextDecoration? decoration;

  TextView({
    this.textKey,
    required this.text,
    this.textOverflow = TextOverflow.clip,
    this.textAlign = TextAlign.left,
    this.color,
    this.onTap,
    this.fontSize = 14.0,
    this.lineHeight,
    this.textStyle,
    this.maxLines,
    this.fontWeight = FontWeight.normal,
    this.decoration,
    this.fontStyle = FontStyle.normal,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        key: textKey,
        style: textStyle ??
            GoogleFonts.mPlus1(
                color: color,
                decoration: decoration,
                fontWeight: fontWeight,
                fontSize: fontSize,
                fontStyle: fontStyle,
                height: lineHeight),
        textAlign: textAlign,
        overflow: textOverflow,
        maxLines: maxLines,
      ),
    );
  }
}
