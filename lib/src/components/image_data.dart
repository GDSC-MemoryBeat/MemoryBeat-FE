import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ImageData extends StatelessWidget {
  final String icon;
  final double? width;
  const ImageData(
    this.icon,{
      Key? key,this.width=55,
      }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SvgPicture.asset(
      icon,
      width:60,
      //width: width! / Get.mediaQuery.devicePixelRatio
      );
  }
}
class IconsPath {
   static String get gameOff => 'assets/images/gaa.svg';
   static String get gameOn => 'assets/images/gaaa.svg';
   static String get scoreOff => 'assets/images/scc.svg';
   static String get scoreOn => 'assets/images/scc_on.svg';
  
}