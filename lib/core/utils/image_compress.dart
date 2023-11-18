import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future<String> compressImage(String path, {int max = 1000}) async {
  var dir = await getTemporaryDirectory();
  var targetPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg';
  var result = await FlutterImageCompress.compressAndGetFile(
    path,
    targetPath,
    quality: 80,
    format: CompressFormat.jpeg,
    minHeight: max,
    minWidth: max,
  );

  if (result == null) {
    return path;
  }
  int fileLength = await result.length();
  if (fileLength > File(path).lengthSync()) {
    return path;
  }
  return result.path;
}
