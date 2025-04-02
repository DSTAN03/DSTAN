import 'dart:io';
import 'package:flutter/material.dart';
import '../gen/assets.gen.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imagePath,
    this.radius = 24.0,
    this.isActive = false,
  });

  final String? imagePath;
  final double radius;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CircleAvatar(
        //   backgroundColor: Colors.red,
        //   radius: radius,
        //   child: CircleAvatar(
        //     backgroundImage: imagePath == null
        //         // ? Assets.images.defaultAvatar.provider()
        //         // ? Image.asset(Assets.images.defaultAvatar.path).image
        //         ? AssetImage(Assets.images.defaultAvatar.path) as ImageProvider
        //         : FileImage(File(imagePath!)),
        //     radius: radius - 1.0,
        //   ),
        // ),
        Container(
          width: radius * 2.0,
          height: radius * 2.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 1.0),
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: imagePath == null
                  // ? Assets.images.defaultAvatar.provider()
                  // ? Image.asset(Assets.images.defaultAvatar.path).image
                  ? AssetImage(Assets.images.defaultAvatar.path)
                      as ImageProvider
                  : FileImage(File(imagePath!)),
            ),
          ),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: imagePath == null
              ? Container(
                  padding: const EdgeInsets.all(2.6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.pink),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 18.0,
                    color: Colors.pink,
                  ),
                )
              // : Container(
              //     padding: const EdgeInsets.all(1.2),
              //     decoration: const BoxDecoration(
              //         color: Colors.white, shape: BoxShape.circle),
              //     child: CircleAvatar(
              //       backgroundColor:
              //           isActive == true ? Colors.green : Colors.orange,
              //       radius: radius / 4.0,
              //     ),
              //   ),
              : Container(
                  width: (radius / 4.0 + 1.2) * 2.0,
                  height: (radius / 4.0 + 1.2) * 2.0,
                  decoration: BoxDecoration(
                    color: isActive == true ? Colors.green : Colors.orange,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.2),
                  ),
                ),
        ),
      ],
    );
  }
}
