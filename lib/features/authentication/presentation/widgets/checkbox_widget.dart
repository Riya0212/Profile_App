import 'package:flutter/material.dart';
import 'package:iml_test_app/src/ui/constants/dimensions.dart';

import '../../../../src/ui/constants/colors.dart';

class CheckboxWidget extends StatefulWidget {
  ///default constructor
  const CheckboxWidget({
    Key? key,
    required this.activeColor,
    required this.onChanged, required this.selected
  }) : super(key: key);

  final Color activeColor;
  final VoidCallback onChanged;
  final bool selected;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
 
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: widget.onChanged,
        child: Container(
          height: Dimensions.dp_20,
          width: Dimensions.dp_20,
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(Dimensions.dp_5)),
              color: widget.selected ? widget.activeColor : Colors.transparent,
              border: Border.all(color: Colors.white)),
          child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: widget.selected
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: Dimensions.dp_15,
                        color: AppColors.buttonTextColor,
                      ),
                    )
                  : Container()),
        ),
      );
}
