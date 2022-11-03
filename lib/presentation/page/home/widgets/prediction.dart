// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/data/model/prediction.model.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({super.key, required this.predictions});
  final List<PredictionModel> predictions;

  Widget _numberWidget(int num, PredictionModel prediction) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Palette.main,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$num',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: prediction == null
                    ? Palette.secondary
                    : Palette.red.withOpacity(
                        (prediction.confidence * 2).clamp(0, 1).toDouble(),
                      ),
              ),
            ),
            prediction != null
                ? Text(
                    '${(prediction.confidence * 100).toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Palette.secondary,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  List<dynamic> getPredictionStyles(List<PredictionModel> predictions) {
    List<dynamic> data = [null, null, null, null, null, null, null, null, null, null];
    for (var prediction in predictions) {
      data[prediction.index] = prediction;
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    var styles = getPredictionStyles(predictions);

    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (var i = 0; i < 3; i++) _numberWidget(i, styles[i])],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (var i = 3; i < 7; i++) _numberWidget(i, styles[i])],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (var i = 7; i < 10; i++) _numberWidget(i, styles[i])],
          )
        ],
      ),
    );
  }
}
