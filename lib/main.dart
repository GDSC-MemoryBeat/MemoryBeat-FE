import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorybeating/src/app.dart';
import 'package:memorybeating/src/binding/init_bindings.dart';
import 'package:permission_handler/permission_handler.dart';
//void main() {
 // runApp(const MyApp());
//}


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request(); // if you need microphone permission
  await Permission.videos.request();
  await Permission.audio.request();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'memory_beat_',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialBinding: InitBinding(),
      //App()는 bottom navigator를 관리하고 페이지를 index에 맞게끔 변환시켜주는 역할입니다.
      home: const App(),
    );
  }
}