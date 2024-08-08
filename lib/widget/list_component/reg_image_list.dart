import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapda/constants/definition/constants.dart';

class RegImageList extends StatelessWidget {
  final XFile file;
  final List<XFile> storeArea;
  final int index;
  final Function(List<XFile>, int) deleteSelectedImage;

  const RegImageList({
    key,
    required this.file,
    required this.storeArea,
    required this.index,
    required this.deleteSelectedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      width: 92,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(File(file.path)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => deleteSelectedImage(storeArea, index),
              child: AppIcon.x_redcircle_24,
            ),
          )
        ],
      ),
    );
  }
}
