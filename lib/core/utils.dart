
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Uri getMapDirectionUrl(lat, long) {
  Uri url;
  if (Platform.isAndroid) {
    url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$long');
  } else {
    url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=$lat,$long');
  }
  return url;
}

Future<File> convertUint8ListToFile(Uint8List uint8List) async {
  // Get the temporary directory
  final tempDir = await getTemporaryDirectory();

  // Create a unique file name in the temporary directory
  final file = File(join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}.png'));

  // Write the Uint8List to the file
  return await file.writeAsBytes(uint8List);
}