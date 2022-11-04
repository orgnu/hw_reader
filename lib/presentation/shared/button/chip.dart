import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.title, required this.icon, required this.onTap});
  final String title;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InputChip(
      backgroundColor: Palette.accent,
      avatar: Icon(
        icon,
        color: Palette.secondary,
      ),
      label: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: Palette.secondary,
        ),
      ),
      onPressed: () => onTap(),
    );
  }
}
