import 'dart:io';
import 'dart:ui';
import 'package:flame/src/image_composition.dart' as ImageComposition;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plinco/services/logger_service.dart';

class ImagesService {
  String basePath = dotenv.env['BASE_PATH']!;
  final _imageCaches = <String, File>{};

  static final ImagesService _instance = ImagesService._internal();

  factory ImagesService() {
    return _instance;
  }

  ImagesService._internal();

  Future<ImageComposition.Image?> getImageByFilename(String fileName) async {
    try {
      final file = _imageCaches[basePath + fileName];
      if (file == null) return null;

      final bytes = await file.readAsBytes();
      final codec = await instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();

      return frame.image;
    } catch (error, stackTrace) {
      const SentryLogging().exception(error, stackTrace);
      return null;
    }
  }

  Future<void> add({
    required String fileName,
    required File file,
  }) async {
    try {
      _imageCaches[basePath + fileName] = file;
    } catch (error, stackTrace) {
      const SentryLogging().exception(error, stackTrace);
    }
  }

  File? getByFilename(String fileName) {
    try {
      return _imageCaches[basePath + fileName];
    } catch (error, stackTrace) {
      const SentryLogging().exception(error, stackTrace);
      return null;
    }
  }

  bool isCached(String fileName) {
    return _imageCaches.containsKey(fileName);
  }
}
