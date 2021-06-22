import 'package:audioplayers/audioplayers.dart';
import 'package:bad_apple/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(MyController());
    return GetMaterialApp(
      title: 'Bad Apple',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends GetView<MyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bad Apple ! !'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int i = 0; i < 18; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < 24; j++)
                  SizedBox(
                      width: 14,
                      height: 14,
                      child: Transform.scale(
                        scale: 0.75,
                        child: Obx(() => Checkbox(
                            value: controller.clicked[i][j].value,
                            onChanged: (_) {})),
                      ))
              ],
            )
        ]),
      ),
    );
  }
}

class MyController extends GetxController {
  List<List<RxBool>> clicked = [
    for (int i = 0; i < 18; i++) [for (int j = 0; j < 24; j++) false.obs]
  ];

  @override
  void onInit() {
    super.onInit();
    _startAudio();
    _animate();
  }

  Future<void> _startAudio() async {
    AudioCache audioCache = AudioCache();
    await audioCache.loop('music.mp3');
  }

  Future<void> _animate() async {
    Future.doWhile(() async {
      for (List<String> frame in animation) {
        for (int i = 0; i < 18; i++) {
          for (int j = 0; j < 24; j++) {
            clicked[i][j].value = frame[i][j] == "1";
          }
        }
        await Future.delayed(Duration(milliseconds: 13));
      }
      return true;
    });
  }
}
