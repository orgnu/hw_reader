import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/data/cubit/recognition/recognition.cubit.dart';
import 'package:hw_reader/presentation/page/home/home.body.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Oxuyucu', style: TextStyle(color: Palette.main, fontSize: 28.sp, fontFamily: 'Pacifico')),
      ),
      body: BlocProvider(
        create: (context) => RecognitionCubit()..init(),
        child: const HomeBody(),
      ),
    );
  }
}
