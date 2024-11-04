import 'package:flutter/material.dart';
import 'package:tots_test/src/ui/common/util/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.borderRadius,
      this.width,
      this.height,
      this.onTap,
      this.child,
      this.text,
      this.padding,});
  final double? borderRadius, width, height;
  final Function()? onTap;
  final Widget? child;
  final String? text;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 34),
      child: Container(
        alignment: Alignment.center,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 14),
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(borderRadius ?? 34),
            boxShadow: [
              BoxShadow(
                color: AppColors.buttonShadow,
                blurRadius: 15,
                offset: const Offset(0, 4),
              )
            ]),
        child: child ??
            Text(
              text ?? '',
              style: const TextStyle(
                color: AppColors.white,
              ),
            ),
      ),
    );
  }
}
