import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/config/size.constants.dart';
import 'package:hw_reader/data/service/tensorflow.service.dart';
import 'package:hw_reader/presentation/page/home/provider.dart';
import 'package:hw_reader/presentation/page/home/widgets/painter.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

class DrawCanvasWidget extends StatelessWidget {
  const DrawCanvasWidget({super.key, required this.service});
  final TensorflowService service;
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomeProvider>();
    return Container(
      width: SizeConstants.canvasSize + SizeConstants.borderSize * 2,
      height: SizeConstants.canvasSize + SizeConstants.borderSize * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Palette.main,
          width: SizeConstants.borderSize,
        ),
      ),
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          Offset localPosition = details.localPosition;
          if (localPosition.dx >= 0 &&
              localPosition.dx <= SizeConstants.canvasSize &&
              localPosition.dy >= 0 &&
              localPosition.dy <= SizeConstants.canvasSize) {
            provider.addPoint(localPosition);
          }
        },
        onPanEnd: (DragEndDetails details) async {
          List<dynamic> pred = await service.recognize(provider.points);
          provider.setPrediction(pred.map((json) => PredictionModel.fromJson(json)).toList());
        },
        child: CustomPaint(
          painter: DrawingPainter(provider.points),
        ),
      ),
    );
  }
}
