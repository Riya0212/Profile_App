import 'package:flutter/material.dart';
import 'package:iml_test_app/src/ui/constants/dimensions.dart';

class ModelBottomSheetWidget extends StatefulWidget {
  const ModelBottomSheetWidget({super.key, required this.onPressed});

final VoidCallback onPressed;
  @override
  State<ModelBottomSheetWidget> createState() => _ModelBottomSheetWidgetState();
}

class _ModelBottomSheetWidgetState extends State<ModelBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.dp_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                IconButton(
                    onPressed: widget.onPressed,
                    icon: const Icon(
                      Icons.camera,
                      color: Colors.white,
                    )),
                const Text(
                  'Camera',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.dp_16),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                    onPressed: widget.onPressed,
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.white,
                    )),
                const Text(
                  'Gallery',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.dp_16),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
                const Text(
                  'Delete',
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimensions.dp_16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  
}
