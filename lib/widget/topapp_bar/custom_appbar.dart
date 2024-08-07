// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class BackAppBarWithClose extends StatelessWidget
    implements PreferredSizeWidget {
  final state, thisBgColor;

  const BackAppBarWithClose({
    super.key,
    this.state,
    this.thisBgColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: thisBgColor ?? AppColors.white,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pop(context, state);
        },
        child: AppIcon.arrow_left_24,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: GestureDetector(
            child: AppIcon.x_24,
          ),
        )
      ],
    );
  }
}

class BackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final state, thisBgColor;

  const BackAppBar({
    super.key,
    this.state,
    this.thisBgColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: thisBgColor ?? AppColors.white,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pop(context, state);
        },
        child: AppIcon.arrow_left_24,
      ),
    );
  }
}
