import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';



class CatchPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CatchPetPage(),
    );
  }
}

class CatchPetPage extends StatefulWidget {
  @override
  _CatchPetPageState createState() => _CatchPetPageState();
}

class _CatchPetPageState extends State<CatchPetPage> {
  CameraController? _controller;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    // 카메라 초기화
    WidgetsFlutterBinding.ensureInitialized();
    availableCameras().then((cameras) {
      final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);

      _controller = CameraController(frontCamera, ResolutionPreset.medium);
      _controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _capturePhoto() async {
    try {
      final image = await _controller!.takePicture();
      setState(() {
        _imagePath = image.path;
      });
      
    } catch (e) {
      print('사진을 캡쳐하는 중에 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Catch Pet!'),
        backgroundColor: Color.fromARGB(255, 44, 60, 143),
      ),
      //color: Color.fromARGB(255, 44, 60, 143),
      body: Center(
        child: CameraPreview(_controller!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _capturePhoto,
        child: Icon(Icons.camera),
        backgroundColor: Color.fromARGB(255, 44, 60, 143),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
