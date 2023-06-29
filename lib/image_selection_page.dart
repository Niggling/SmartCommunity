import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImageSelectionPage {
  static Future<Uint8List?> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List? imageBytes = await pickedFile.readAsBytes();
      return imageBytes;
    } else {
      return null;
    }
  }
}
