import 'dart:io';

class CardInfo {
  final String imageAsset;
  final String title;
  final String description;
  final File? audioFile;

  CardInfo({
    required this.imageAsset,
    required this.title,
    required this.description,
     this.audioFile,
  });
}
