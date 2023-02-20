import 'dart:ui' as ui;
import 'dart:typed_data';

/// Resizes the image [rawImage] to [width] and [height].
///
/// If only width or height are specified, the resized
/// image will keep the aspect ratio.
Future<ByteData?> resizeImage(Uint8List rawImage, {int? width, int? height}) async {
  final codec = await ui.instantiateImageCodec(rawImage, targetWidth: width, targetHeight: height);
  final resizedImage = (await codec.getNextFrame()).image;
  return resizedImage.toByteData(format: ui.ImageByteFormat.png);
}
