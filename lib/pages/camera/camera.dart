// import 'package:camera/camera.dart';
// import 'package:erp_banchangtong/pages/camera/test.dart';
// import 'package:flutter/material.dart';

// class CameraApp extends StatefulWidget {
//   const CameraApp({required this.cameras, Key? key}) : super(key: key);
//   final List<CameraDescription> cameras;

//   @override
//   State<CameraApp> createState() => _CameraAppState();
// }

// class _CameraAppState extends State<CameraApp> {
//   late CameraController _controller;
//   @override
//   void initState() {
//     //TODO implement initState
//     super.initState();
//     _controller = CameraController(widget.cameras[0], ResolutionPreset.max);
//     _controller.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             break;
//           default:
//             break;
//         }
//       }
//     });
//   }

//     @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             height: double.infinity,
//             child: CameraPreview(_controller),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   margin: const EdgeInsets.all(20.0),
//                   child: MaterialButton(
//                     onPressed: () async {
//                       if (!_controller.value.isInitialized) {
//                         return null;
//                       }
//                       if (_controller.value.isTakingPicture) {
//                         return null;
//                       }
//                       try {
//                         await _controller.setFlashMode(FlashMode.off);
//                         XFile file = await _controller.takePicture();
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePreview(file)));
//                       } on CameraException catch (e) {
//                         debugPrint("Error occured while taking picture : $e");
//                         return null;
//                       }
//                     },
//                     color: Colors.white,
//                     child: const Text("Text a picture"),
//                   ),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
