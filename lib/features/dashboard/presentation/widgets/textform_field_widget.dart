import 'package:flutter/material.dart';
import 'package:iml_test_app/src/ui/constants/colors.dart';
import 'package:iml_test_app/src/ui/constants/dimensions.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String labelText;

  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController textController;
  final bool hasMaxLines;
  final String? errorText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final void Function(String)? onChanged;

  const TextFormFieldWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.textInputType,
    required this.textInputAction,
    required this.textController,
    required this.validator,
    this.errorText,
    this.onChanged,
    required this.hasMaxLines, required this.isEnabled, required this.initialValue,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.dp_5),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        style: const TextStyle(color: Colors.black),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLines: widget.hasMaxLines ? null : 1,
        enabled: widget.isEnabled,
        
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          errorText: widget.errorText,
          errorStyle: const TextStyle(color: Colors.redAccent),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkBlue),
              borderRadius: const BorderRadius.all(Radius.circular(
                Dimensions.dp_10,
              ))),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkBlue),
              borderRadius: const BorderRadius.all(Radius.circular(
                Dimensions.dp_10,
              ))),
          hintStyle:
              TextStyle(color: AppColors.darkBlue, fontSize: Dimensions.dp_16),
          labelStyle: TextStyle(
              color: AppColors.darkBlue,
              fontSize: Dimensions.dp_18,
              fontWeight: FontWeight.bold),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
