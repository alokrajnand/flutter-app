import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String header;
  final String description;

  Slide(
      {@required this.imageUrl,
      @required this.header,
      @required this.description});
}

final slideList = [
  Slide(
      imageUrl: 'assets/images/ob-img-1.png',
      header: 'A Header one',
      description: 'this is the first description'),
  Slide(
      imageUrl: 'assets/images/ob-img-2.png',
      header: 'A Header two',
      description: 'this is the second description'),
  Slide(
      imageUrl: 'assets/images/ob-img-3.png',
      header: 'A Header third',
      description: 'this is the third description'),
];
