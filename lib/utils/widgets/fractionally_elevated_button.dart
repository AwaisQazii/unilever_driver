import 'package:flutter/material.dart';
import 'package:unilever_driver/utils/app_colors.dart';

class FractionallyElevatedButton extends StatelessWidget {
  const FractionallyElevatedButton({
    super.key,
    required this.onTap,
    this.widthFactor,
    this.backgroundColor,
    this.child,
  });

  final Widget? child;
  final double? widthFactor;
  final VoidCallback onTap;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width * (widthFactor ?? 0.5)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // shadowColor: AppColors.primaryColor,
          padding: EdgeInsets.zero,
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          elevation: 0,
          side: const BorderSide(color: AppColors.black),
          visualDensity: const VisualDensity(
            vertical: 2,
            horizontal: 2,
          ),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
