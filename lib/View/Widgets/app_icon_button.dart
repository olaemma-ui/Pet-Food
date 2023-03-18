import 'package:flutter/material.dart';
import 'package:pet_food/View/UiManager/Color.manager.dart';

class AppIconButton extends StatelessWidget {
  Widget icon;
  Function? onPressed;
  AppIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(1000)),
      child: IconButton(
        color: ColorManager.light,
        splashRadius: 25,
        icon: icon,
        onPressed: () {
          onPressed!();
        },
      ),
    );
  }
}
