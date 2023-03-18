import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_food/Service/app.ervice.dart';
import 'package:pet_food/Service/database.service.dart';
import 'package:pet_food/Service/notification.manager.dart';
import 'package:pet_food/View/UiManager/Color.manager.dart';
import 'package:pet_food/View/UiManager/app_theme.dart';
import 'package:pet_food/View/Widgets/app_icon_button.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  var theme = AppTheme.themeData();
  bool preview = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.light,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppIconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Image.asset('asset/pet.png'),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: Ink(
                          padding: const EdgeInsets.all(12.0),
                          width: 500,
                          // height: 500,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)),
                              color: ColorManager.secondary),

                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('asset/fork.png'),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          CircleAvatar(
                                              backgroundColor:
                                                  ColorManager.dark,
                                              backgroundImage: (preview)
                                                  ? Image.file(CameraService
                                                          .imageFile!)
                                                      .image
                                                  : null,
                                              radius: 100,
                                              child: (!preview)
                                                  ? const CameraScreen()
                                                  : null),
                                          Positioned(
                                            left: 160,
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: AppIconButton(
                                                  icon: const Icon(
                                                      Icons.close_rounded),
                                                  onPressed: () {
                                                    setState(() {
                                                      preview = false;
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Image.asset('asset/spoon.png')
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  (!preview)
                                      ? 'Click your meal'
                                      : 'Will you eat this ?',
                                  style: AppTheme.themeData(
                                          color: ColorManager.dark)
                                      .textTheme
                                      .bodyLarge,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                AppIconButton(
                                    icon: (!loading)
                                        ? Icon(
                                            (!preview)
                                                ? Icons.camera_alt
                                                : Icons.check,
                                            // size: 20,
                                          )
                                        : SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              color: ColorManager.light,
                                            ),
                                          ),
                                    onPressed: (!loading)
                                        ? () async {
                                            log('preview = $preview');
                                            log('loading = $loading');
                                            if (!preview) {
                                              CameraService.imageFile =
                                                  await CameraService.capture(
                                                      controller: CameraService
                                                          .controller);
                                              preview = true;
                                            } else {
                                              loading = true;
                                              setState(() {});
                                              await DatabaseService.uploadFood(
                                                  file:
                                                      CameraService.imageFile!,
                                                  fileName:
                                                      '${DateTime.now()}.jpeg');
                                              loading = false;
                                            }
                                            setState(() {});
                                          }
                                        : null)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
