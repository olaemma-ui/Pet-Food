import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class CameraService {
  static CameraController? controller;
  static List<CameraDescription> cameras = [];
  static File? imageFile;
  static loadCameras() async {
    cameras = await availableCameras();
  }

  static capture({CameraController? controller}) async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) return null;
    try {
      XFile? file = await cameraController.takePicture();
      imageFile = File(file.path);

      int currentUnix = DateTime.now().millisecondsSinceEpoch;
      final directory = await getApplicationDocumentsDirectory();
      String fileFormat = imageFile!.path.split('.').last;

      await imageFile!.copy('${directory.path}/$currentUnix.$fileFormat');
      log('picture = ${imageFile}');
      return imageFile;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  bool _isCameraInitialized = false;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final prevCameraController = CameraService.controller;
    CameraController cameraController = CameraController(
        cameraDescription, ResolutionPreset.ultraHigh,
        imageFormatGroup: ImageFormatGroup.yuv420);

    await prevCameraController?.dispose();

    if (mounted) {
      setState(() {
        CameraService.controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } catch (e) {
      e.printError();
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = CameraService.controller!.value.isInitialized;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = CameraService.controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    onNewCameraSelected(CameraService.cameras[0]);
    // WidgetsBinding
    super.initState();
  }

  @override
  void dispose() {
    CameraService.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isCameraInitialized
        ? ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(10000),
            child: AspectRatio(
              aspectRatio: 1,
              child: CameraService.controller!.buildPreview(),
            ),
          )
        : Container();
  }
}
