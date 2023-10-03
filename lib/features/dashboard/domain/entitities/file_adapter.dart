import 'dart:io';
import 'package:hive/hive.dart';

class FileAdapter extends TypeAdapter<File> {
  @override
  final int typeId = 2; // Use a unique ID for your type

  @override
  File read(BinaryReader reader) {
    final filePath = reader.readString();
    return File(filePath);
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer.writeString(obj.path);
  }
}
