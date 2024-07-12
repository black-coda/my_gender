import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Base64 Image Extension
extension Base64ImageExtension on String {
  Future<String> _base64ToFile() async {
    final base64String = split(',')[1];
    final decodedBytes = base64Decode(base64String);

    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    final file = File(filePath);
    await file.writeAsBytes(decodedBytes);

    return filePath;
  }

  Future<CachedNetworkImage> toCachedNetworkImage() async {
    final filePath = await _base64ToFile();
    return CachedNetworkImage(
      imageUrl: 'file://$filePath',
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}