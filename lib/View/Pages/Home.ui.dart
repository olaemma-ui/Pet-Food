import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_food/View/UiManager/Color.manager.dart';
import 'package:pet_food/View/UiManager/app_theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  var theme = AppTheme.themeData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('asset/dish.jfif'),
                radius: 100,
                backgroundColor: ColorManager.light,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                child: Text(
                  "Share your meal",
                  style: theme.textTheme.bodyLarge,
                ),
                onPressed: () {
                  Get.toNamed('/foodPage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
