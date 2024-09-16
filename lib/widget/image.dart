// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:image_picker/image_picker.dart';

Pickimage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No");
}
