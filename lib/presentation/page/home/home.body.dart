// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/data/cubit/recognition/recognition.cubit.dart';
import 'package:hw_reader/data/service/tensorflow.service.dart';
import 'package:hw_reader/presentation/page/home/widgets/drawcanvas.dart';
import 'package:hw_reader/presentation/page/home/widgets/prediction.dart';
import 'package:hw_reader/presentation/shared/button/chip.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

import 'provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecognitionCubit, RecognitionState>(
      builder: (context, state) {
        if (state is RecognitionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RecognitionSuccess) {
          TensorflowService service = state.service;
          var provider = context.watch<HomeProvider>();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomChip(
                      icon: Icons.camera,
                      title: "Kamera",
                      onTap: () {
                        //  provider.openCamera()
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Palette.accent,
                            elevation: 0,
                            content: Center(
                              child: Text('Vaxt tapan kimi...'),
                            ),
                          ),
                        );
                      },
                    ),
                    CustomChip(
                      icon: CupertinoIcons.clear_thick_circled,
                      title: "Təmizlə",
                      onTap: () {
                        provider.clearBoard();
                      },
                    )
                  ],
                ),
                SizedBox(height: 24.h),
                DrawCanvasWidget(service: service),
                SizedBox(height: 24.h),
                PredictionWidget(predictions: provider.prediction),
              ],
            ),
          );
        } else if (state is RecognitionError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const Center(
          child: Text('Bilinmeyen xeta'),
        );
      },
    );
  }
}
