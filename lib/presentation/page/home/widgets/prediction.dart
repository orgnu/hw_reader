// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/data/model/prediction.model.dart';
import 'package:hw_reader/presentation/page/home/widgets/number.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({super.key, required this.predictions});
  final List<PredictionModel>? predictions;

  List<dynamic> getPredictionStyles(List<PredictionModel>? predictions) {
    List<dynamic> data = [null, null, null, null, null, null, null, null, null, null];
    for (var prediction in predictions ?? []) {
      data[prediction.index] = prediction;
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    var styles = getPredictionStyles(predictions);

    return Container(
      width: 375.w - 20,
      decoration: BoxDecoration(color: Palette.white, borderRadius: BorderRadius.circular(20.r)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [for (var i = 0; i < 3; i++) NumberWidget(num: i, prediction: styles[i])],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [for (var i = 3; i < 7; i++) NumberWidget(num: i, prediction: styles[i])],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [for (var i = 7; i < 10; i++) NumberWidget(num: i, prediction: styles[i])],
            )
          ],
        ),
      ),
    );
  }
}
