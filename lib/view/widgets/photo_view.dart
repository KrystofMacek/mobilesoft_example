import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class PhotoView extends StatelessWidget {
//   const PhotoView({
//     Key? key,
//     required this.photoData,
//     required this.dimension,
//   }) : super(key: key);

//   final Uint8List photoData;
//   final double dimension;

//   @override
//   Widget build(BuildContext context) {
//     Widget _employeePhoto = SizedBox(height: dimension, width: dimension);
//     if (photoData.isNotEmpty) {
//       _employeePhoto = Image.memory(
//         photoData,
//         width: dimension,
//         height: dimension,
//         errorBuilder: (_, __, ___) {
//           return SizedBox(
//             height: dimension,
//             width: dimension,
//           );
//         },
//       );
//     }

//     return _employeePhoto;
//   }
// }

class PhotoView extends StatelessWidget {
  const PhotoView({
    Key? key,
    required this.photoUrl,
    required this.dimension,
  }) : super(key: key);

  final String photoUrl;
  final double dimension;

  @override
  Widget build(BuildContext context) {
    Widget _employeePhoto = Image.asset(
      'assets/placeholder.png',
      height: dimension,
      width: dimension,
    );
    if (photoUrl.isNotEmpty) {
      try {
        _employeePhoto = CachedNetworkImage(
          imageUrl: 'http://testapp.mobilesoft.cz$photoUrl',
          width: dimension,
          height: dimension,
          fadeInDuration: const Duration(milliseconds: 100),
          placeholder: (context, url) => Image.asset(
            'assets/placeholder.png',
            height: dimension,
            width: dimension,
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/placeholder.png',
            height: dimension,
            width: dimension,
          ),
        );
      } catch (e) {
        Get.snackbar('PhotoView', e.toString());
      }
    }

    return _employeePhoto;
  }
}
