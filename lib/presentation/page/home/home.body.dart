// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/config/size.constants.dart';
import 'package:hw_reader/data/cubit/recognition/recognition_cubit.dart';
import 'package:hw_reader/data/model/prediction.model.dart';
import 'package:hw_reader/data/service/tensorflow.service.dart';
import 'package:hw_reader/presentation/page/home/widgets/painter.dart';
import 'package:hw_reader/presentation/page/home/widgets/prediction.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final _points = <Offset>[];
  late TensorflowService _service;
  List<PredictionModel> _prediction = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecognitionCubit, RecognitionState>(
      builder: (context, state) {
        if (state is RecognitionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RecognitionSuccess) {
          _service = state.service;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InputChip(
                      backgroundColor: Palette.accent,
                      avatar: const Icon(
                        Icons.camera,
                        color: Palette.secondary,
                      ),
                      label: Text(
                        'Kamera',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Palette.secondary,
                        ),
                      ),
                      onPressed: () {
                        // context.read<RecognitionCubit>().recognizeFromCamera();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: Palette.accent,
                            elevation: 0,
                            content: Center(child: Text('Vaxt tapan kimi.'))));
                        // setState(() {
                        //   _points.clear();
                        //   _prediction.clear();
                        // });
                      }),
                  InputChip(
                      backgroundColor: Palette.accent,
                      avatar: const Icon(
                        CupertinoIcons.clear_thick_circled,
                        color: Palette.secondary,
                      ),
                      label: Text(
                        'Təmizlə',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Palette.secondary,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _points.clear();
                          _prediction.clear();
                        });
                      }),
                ],
              ),
              SizedBox(height: 8.h),
              _drawCanvasWidget(),
              SizedBox(height: 8.h),
              PredictionWidget(
                predictions: _prediction,
              ),
            ],
          );
        } else if (state is RecognitionError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: Text('Unknown error'),
        );
      },
    );
  }

  Widget _drawCanvasWidget() {
    return Container(
      width: SizeConstants.canvasSize + SizeConstants.borderSize * 2,
      height: SizeConstants.canvasSize + SizeConstants.borderSize * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
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
            setState(() {
              _points.add(localPosition);
            });
          }
        },
        onPanEnd: (DragEndDetails details) {
          _recognize();
        },
        child: CustomPaint(
          painter: DrawingPainter(_points),
        ),
      ),
    );
  }

  void _recognize() async {
    List<dynamic> pred = await _service.recognize(_points);
    setState(() {
      _prediction = pred.map((json) => PredictionModel.fromJson(json)).toList();
    });
  }
}
