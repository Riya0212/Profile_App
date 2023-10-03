import 'package:flutter/material.dart';
import 'package:iml_test_app/src/ui/constants/colors.dart';

import '../../../../src/ui/constants/dimensions.dart';

class CustomButtonHeading extends StatelessWidget {
  final String headingText;

  const CustomButtonHeading({super.key, required this.headingText});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkBlue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
        ),
      ),
      elevation: 2,
      child: SizedBox(
        height: Dimensions.dp_45,
        width: Dimensions.dp_150,
        
        
        child: Center(
          child: Text(
        
            headingText,
            textAlign: TextAlign.left,
            style: const TextStyle(
        
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.dp_18,
            ),
          ),
        ),
      ),
    );

  }
}
