import 'package:flutter/material.dart';
import 'package:mapda/constants/definition/constants.dart';

class MovementRegState extends StatelessWidget {
  final int thisState;
  const MovementRegState({super.key, required this.thisState});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Distribute space evenly
      children: List.generate(8, (index) {
        return Expanded(
          child: Container(
            height: 4.0, // Set the height to 4
            decoration: BoxDecoration(
              color: thisState > index
                  ? AppColors.p_7_base
                  : AppColors.g_2, // Adjust color based on the index
              borderRadius: index == thisState - 1
                  ? const BorderRadius.only(
                      topRight: Radius.circular(2),
                      bottomRight: Radius.circular(2),
                    )
                  : null,
            ),
          ),
        );
      }),
    );
  }
}
