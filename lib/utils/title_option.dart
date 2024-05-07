import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleOption extends Text {
  TitleOption({
    required String data,
    required Color color,
    required double size,
    required FontWeight weight,
    int? maxLines,
    TextOverflow? overflow,
    TextAlign? textAlign,
    FontStyle? style,
    String? fontFamily, 
    List<FontFeature>? fontFeatures // Use String for the font family
  }) : super(
    data,
    textAlign: textAlign,
    style : TextStyle(
      fontFamily: 'SFProDisplay',
      color: color ,
      fontSize:size ,
      fontWeight :weight ,
      fontFeatures: fontFeatures,
      //fontStyle: style
    ),
    overflow: TextOverflow.clip,
    maxLines: maxLines,
    
  );
}
