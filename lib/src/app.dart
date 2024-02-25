import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorybeating/src/components/image_data.dart';
import 'package:memorybeating/src/controller/bottom_navigator.dart';
import 'package:memorybeating/src/pages/home.dart';
import 'package:memorybeating/src/pages/scores.dart';

class App extends GetView<BottomNavController>{
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Obx(() => Scaffold(
        appBar: AppBar(),
        body: IndexedStack(
          index: controller.pageIndex.value,
          children: [
            Home(),
            ScorePage(),
            //Container(
              //child: const Center(child: Text('profile')),
            //),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(255, 151, 133, 94), 
         
          showSelectedLabels: false,
        showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.pageIndex.value,
          elevation: 10,
          onTap: controller.changeBottomNav,
          items: [
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.gameOff, // 아이콘의 너비 조절
                ),
              activeIcon: ImageData(IconsPath.gameOn),
              label: 'Game',
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.scoreOff),
              activeIcon: ImageData(IconsPath.scoreOn),
              label: 'Score',
            ),
            
          ],
        ),
      )),
    );
  }
}
