import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';
import 'package:mapda/manage/api/object_api_manage.dart';
import 'package:mapda/constants/manage/model_manage.dart';

class SpecificObjectScreen extends StatefulWidget {
  final int objectId;

  const SpecificObjectScreen({
    super.key,
    required this.objectId,
  });

  @override
  State<SpecificObjectScreen> createState() => _SpecificObjectScreenState();
}

class _SpecificObjectScreenState extends State<SpecificObjectScreen> {
  ObjectListModel? specificObject;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSpecificObject();
  }

  Future<void> fetchSpecificObject() async {
    try {
      ObjectListModel object =
          await ObjectApiManage.getSpecificObject(id: widget.objectId);
      setState(() {
        specificObject = object;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // 에러 처리 (예: 스낵바로 사용자에게 알림)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load object: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Specific Object'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : specificObject == null
              ? const Center(child: Text('No data available'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 480,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Image.network(
                            specificObject!.imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: double.infinity,
                            height: 480,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  AppColors.s_b.withOpacity(0),
                                  AppColors.s_b.withOpacity(0.8)
                                ])),
                          ),
                          Positioned(
                              bottom: 24,
                              left: 24,
                              child: Row(
                                children: [
                                  AppIcon.pin_red_24,
                                  Gaps.h16,
                                  Text(
                                    specificObject!.objectName,
                                    style: AppTextStyles.B_16
                                        .copyWith(color: AppColors.s_w),
                                  )
                                ],
                              )),
                          Positioned(
                            bottom: 24,
                            right: 24,
                            child: Text(
                              '등록 | ${specificObject!.createdAt}',
                              style: AppTextStyles.R_10
                                  .copyWith(color: AppColors.s_w),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v34,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '해당 장소명',
                            style: AppTextStyles.B_14
                                .copyWith(color: AppColors.g_10),
                          ),
                          Gaps.v8,
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColors.g_1,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              specificObject!.placeName,
                              style: AppTextStyles.R_16
                                  .copyWith(color: AppColors.g_10),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
    );
  }
}
