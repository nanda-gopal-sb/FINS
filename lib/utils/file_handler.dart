import "package:fins/components/assets.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";

Future<Uint8List> getAssetAsUint8List(String path) async {
  return (await rootBundle.load(path)).buffer.asUint8List();
}

/// Returns a image based on type of image provided,
/// if image can't be loaded, this returns a default profile picture
///
/// Uint8List -> MemoryImage
///
/// String -> NetworkImage (TODO: check if argument is url)
ImageProvider fetchImageSafely(dynamic image) {
  var img = defaultPfp;
  if (image is Uint8List) {
    try {
      img = MemoryImage(image);
    } catch (err) {/* pass */}
  } else if (image is String && image.isNotEmpty) {
    try {
      img = NetworkImage(image);
    } catch (err) {/* pass */}
  }
  return img;
}
