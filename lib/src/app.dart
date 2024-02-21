import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorybeating/src/components/image_data.dart';
import 'package:memorybeating/src/controller/bottom_navigator.dart';
import 'package:memorybeating/src/pages/home.dart';

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
            Container(
              child: const Center(child: Text('festival')),
            ),
            Container(
              child: const Center(child: Text('profile')),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.pageIndex.value,
          elevation: 4,
          onTap: controller.changeBottomNav,
          items: [
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.nftOff),
              activeIcon: ImageData(IconsPath.nftOn),
              label: 'nft',
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.festOff),
              activeIcon: ImageData(IconsPath.festOn),
              label: 'festival',
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.profileOff),
              activeIcon: ImageData(IconsPath.profileOn),
              label: 'profile',
            ),
          ],
        ),
      )),
    );
  }
}
