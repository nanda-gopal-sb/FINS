import "package:flutter/services.dart";

Future<Uint8List> getAssetAsUint8List(String path) async {
  return (await rootBundle.load(path)).buffer.asUint8List();
}
