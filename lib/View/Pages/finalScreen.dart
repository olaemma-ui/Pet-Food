import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_food/View/UiManager/Color.manager.dart';
import 'package:pet_food/View/UiManager/app_theme.dart';

class FinalScreen extends StatelessWidget {
  FinalScreen({super.key});
  var theme = AppTheme.themeData(color: ColorManager.primary);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'GOOD JOB',
            style: theme.textTheme.headlineLarge,
          ),
        ),
      ),
    );
  }
}
