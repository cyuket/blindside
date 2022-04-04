import 'dart:typed_data';

import 'package:blindside/app/shared/colors.dart';
import 'package:blindside/app/shared/fonts.dart';
import 'package:blindside/core/navigators/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  const AssetThumbnail(
      {Key? key, required this.asset, this.isHorizontal = false})
      : super(key: key);
  final AssetEntity asset;
  final bool isHorizontal;
  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailData,
      builder: (_, snapshot) {
        final date = DateFormat().add_yMMMMd().format(
              asset.createDateTime,
            );
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) return const CircularProgressIndicator();
        // If there's data, display it as an image
        return InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.videoDetail,
              arguments: asset.file,
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: isHorizontal ? 10 : 2,
            ),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              elevation: 2,
              child: SizedBox(
                height: 250,
                width: isHorizontal ? 250 : double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          // Wrap the image in a Positioned.fill to fill the space
                          Positioned.fill(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  image: MemoryImage(bytes),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              // child: Image.memory(bytes, fit: BoxFit.cover),
                            ),
                          ),
                          // Display a Play icon if the asset is a video

                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextRegular(
                            date,
                            color: AppColors.blackColor70,
                          ),
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.yellowColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
