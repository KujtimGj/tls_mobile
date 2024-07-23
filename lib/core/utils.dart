
import 'dart:io';

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