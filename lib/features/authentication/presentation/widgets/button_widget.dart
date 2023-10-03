import 'package:flutter/material.dart';
import 'package:iml_test_app/src/ui/constants/assets.dart';
import 'package:iml_test_app/src/ui/constants/colors.dart';
import 'package:iml_test_app/src/ui/constants/dimensions.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? btnWidth;
  final bool hasLeading;
  final Widget? leadingAsset;
  final Color backgroundColor;
  final Color textColor;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.hasLeading,
    required this.leadingAsset,
    this.btnWidth, required this.backgroundColor, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.dp_5),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: Dimensions.dp_50,
          width: btnWidth,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(Dimensions.dp_10)),
          child: hasLeading? Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                decoration:  const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.googleLogo),
                      scale: 0.2,
                      fit: BoxFit.fill),
                ),
              ),
               Text(
                'Sign in with Google',
                style: TextStyle(
                    fontSize: Dimensions.dp_16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.buttonTextColor),
                         ),
            ]
          ):
          
          
           Center(
            child: Text(text,
                style: TextStyle(
                    color: textColor,
                    fontSize: Dimensions.dp_18,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
