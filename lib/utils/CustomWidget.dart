import 'package:flutter/material.dart';

class CustomWidget {
  Widget textCus(data, fontsize, fontweight) {
    return Text(
      data,
      style: TextStyle(
          fontFamily: 'arabic', fontSize: fontsize, fontWeight: fontweight),
    );
  }

  Widget textCus2(data, fontsize, fontweight) {
    return Text(
      data,
      style: TextStyle(
          fontFamily: 'arabic', fontSize: fontsize, fontWeight: fontweight),
      textAlign: TextAlign.right,
    );
  }

  Widget textCus1(data, fontsize, fontweight) {
    return Text(
      data,
      style: TextStyle(fontSize: fontsize, fontWeight: fontweight),
    );
  }

  Widget paddingCus(padding, child) {
    return Padding(
      padding: padding,
      child: child,
    );
  }

  Widget alignCus(align, child) {
    return Align(
      alignment: align,
      child: child,
    );
  }
}
