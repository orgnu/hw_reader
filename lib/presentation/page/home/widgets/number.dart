// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/presentation/page/home/provider.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

class NumberWidget extends StatelessWidget {
  const NumberWidget({super.key, required this.num, required this.prediction});
  final int num;
  final PredictionModel? prediction;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: prediction == null
            ? Palette.main
            : Palette.accent.withOpacity(
                (prediction!.confidence * 2).clamp(0, 1).toDouble(),
              ),
      ),
      padding: EdgeInsets.all(12.r),
      width: 80.w,
      height: 85.h,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$num',
              style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: prediction == null ? Palette.white : Palette.black),
            ),
            prediction != null
                ? Text(
                    '${(prediction!.confidence * 100).toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Palette.black,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
