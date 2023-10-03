import 'package:flutter/material.dart';

///reusable custom textfield widget
class CustomTextfieldWidget extends StatelessWidget {
  ///default constructor
  const CustomTextfieldWidget(
      {super.key, required this.textEditingController,
      required this.hintText,
      required this.onChanged});

  ///textediting controller var
  final TextEditingController textEditingController;

  ///hinttext var
  final String hintText;

  ///function to perform when offset value is changed
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 200,
        child: TextField(
          onChanged: (String val) {
            onChanged(val);
          },
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.number,
          controller: textEditingController,
        
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blueGrey,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white)),
        ),
      );
}
