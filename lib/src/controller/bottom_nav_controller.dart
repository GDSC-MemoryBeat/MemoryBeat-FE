import 'package:flutter/material.dart';
import 'package:flutter_sns_form/src/pages/upload.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController{
  RxInt pageIndex = 0.obs;



  void changeBottomNav(int value) {
    
    if(value ==0){
      //home event
      _changePage(value);
    }
    if(value ==1){
      //search event
      _changePage(value);
    }
    if(value ==2){
      //upload event
      Get.to(() => const Upload());
    }
    if(value ==3){
      //activity event
      _changePage(value);
    }
    if(value ==4){
      //mypage event
      _changePage(value);
    }
  }
  //upload제외새로운 페이지가 떠야행!
  void _changePage(int value){
      pageIndex(value);
  }
}