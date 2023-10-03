import 'package:flutter/material.dart';
import 'package:iml_test_app/src/ui/constants/dimensions.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  final String labelText;
  final Icon? leadingIcon;
  final String hintText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController textController;
  final bool ifPassword;
  final String? errorText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextFormFieldWidget({
    super.key,
    required this.labelText,
    required this.leadingIcon,
    required this.hintText,
    required this.textInputType,
    required this.textInputAction,
    required this.textController,
    required this.ifPassword,
    required this.validator, this.errorText, this.onChanged,
  });

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  bool passToggle = true;
 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.dp_5),
      child: TextFormField(
        controller: widget.textController,
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        style: const TextStyle(color: Colors.white),
        obscureText: widget.ifPassword ? passToggle: false,
      
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          prefixIcon: widget.leadingIcon,
          errorText: widget.errorText,
          suffixIcon: widget.ifPassword

              ? InkWell(
                  onTap: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                  child: passToggle
                      ? const Icon(
                          Icons.visibility_off,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: Colors.white,
                        ),
                )
              : null,

              
          errorStyle: const TextStyle(color: Colors.redAccent),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(
                Dimensions.dp_10,
              ))),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(
                Dimensions.dp_10,
              ))),
          hintStyle: const TextStyle(
              color: Colors.white, fontSize: Dimensions.dp_16),
          labelStyle: const TextStyle(
              color: Colors.white, fontSize: Dimensions.dp_18),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
