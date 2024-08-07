import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? textFieldController;
  final Widget? extraWidget;
  final String? hintText;

  const CustomTextfield({
    super.key,
    this.textFieldController,
    this.extraWidget,
    this.hintText,
  });

  @override
  State<CustomTextfield> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.g_1,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 48,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: AppTextStyles.R_16.copyWith(color: AppColors.g_10),
              maxLines: 1,
              controller: widget.textFieldController, // 컨트롤러 설정
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 6),
              ),
            ),
          ),
          widget.extraWidget ?? const SizedBox(),
        ],
      ),
    );
  }
}
