import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/presentation/page/home/home.page.dart';
import 'package:hw_reader/presentation/shared/palette/theme.dart';

import 'presentation/page/home/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.light,
          home: ChangeNotifierProvider(
            create: (context) => HomeProvider(),
            child: const HomePage(),
          ),
        );
      },
    );
  }
}
