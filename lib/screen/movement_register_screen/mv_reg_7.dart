import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementReg7Image extends StatefulWidget {
  const MovementReg7Image({super.key});

  @override
  State<MovementReg7Image> createState() => _MovementReg7ImageState();
}

class _MovementReg7ImageState extends State<MovementReg7Image> {
  List<XFile>? inDoorImage = []; // 실내 이미지
  List<XFile>? outDoorImage = []; // 실외 이미지

  final ImagePicker _picker = ImagePicker();

  // 이미지를 가져오는 함수
  Future<void> getImages(ImageSource source, List<XFile>? storeArea) async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    setState(() {
      storeArea!.addAll(pickedFiles); // 선택된 여러 이미지 저장
    });
  }

  // 이미지를 삭제하는 함수
  void deleteSelectedImage(List<XFile> storeArea, int index) {
    setState(() {
      storeArea.removeAt(index); // 해당 인덱스의 이미지를 리스트에서 삭제
    });
  }

  // 이미지 선택 위젯
  Widget imageSelectWidget(List<XFile>? storeArea) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.g_1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          storeArea!.isEmpty
              ? Text(
                  '라이브러리에서 선택',
                  style: AppTextStyles.R_16.copyWith(color: AppColors.g_5),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: storeArea.map((file) {
                        int index = storeArea.indexOf(file);
                        return RegImageList(
                          file: file,
                          storeArea: storeArea,
                          index: index,
                          deleteSelectedImage: deleteSelectedImage,
                        );
                      }).toList(),
                    ),
                  ),
                ),
          GestureDetector(
            onTap: () => getImages(ImageSource.gallery, storeArea),
            child: const Icon(Icons.add_photo_alternate),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v64,
            Text(
              '해당 장소에 등록할\n사진이 있으면 올려주세요',
              style: AppTextStyles.B_24.copyWith(color: AppColors.g_10),
            ),
            Gaps.v52,
            Text(
              '실내',
              style: AppTextStyles.B_14.copyWith(color: AppColors.g_10),
            ),
            Gaps.v8,
            imageSelectWidget(inDoorImage),
            Gaps.v32,
            Text(
              '실외',
              style: AppTextStyles.B_14.copyWith(color: AppColors.g_10),
            ),
            Gaps.v8,
            imageSelectWidget(outDoorImage),
          ],
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Column(
            children: [
              InkWell(
                onTap: null,
                child: Ink(
                    height: 36,
                    width: 68,
                    color: AppColors.s_w,
                    child: Center(
                        child: Text(
                      '건너뛰기',
                      style: AppTextStyles.B_14.copyWith(color: AppColors.g_5),
                    ))),
              ),
              Gaps.v13,
              NextButton(
                thisText: '다음으로',
                isReady: inDoorImage!.isNotEmpty || outDoorImage!.isNotEmpty,
                thisTap: null,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
