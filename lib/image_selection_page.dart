import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:async';

class ImageSelectionPage {
  static Future<Uint8List?> pickImage() async {
    final completer = Completer<Uint8List?>();

    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((html.Event e) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((html.Event e) {
          final result = reader.result as Uint8List?;
          if (result != null) {
            completer.complete(result);
          } else {
            completer.completeError('Failed to read image file');
          }
        });
      } else {
        completer.complete(null);
      }
    });

    return completer.future;
  }
}
