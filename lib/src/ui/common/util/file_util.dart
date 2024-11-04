import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart' as mime;

class FileUtils {

   /// Returns the [file] mime type.
  static Future<String?> getMimeType(File file) async {
    // Read only the needed bytes.
    final bytes =
        await file.openRead(0, mime.defaultMagicNumbersMaxLength).toList();

    return mime.lookupMimeType(file.path, headerBytes: bytes.firstOrNull ?? []);
  }
  /// Returns the [MediaType] for the [file].
  static Future<MediaType?> getMediaType(File file) async {
    final mimeType = await getMimeType(file);
    if (mimeType == null) return null;

    try {
      return MediaType.parse(mimeType);
    } catch (_) {
      return null;
    }
  }

}
