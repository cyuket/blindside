// ignore_for_file: avoid_dynamic_calls

import 'package:blindside/app/shared/colors.dart';
import 'package:blindside/app/shared/fonts.dart';
import 'package:blindside/app/view/base_view.dart';
import 'package:blindside/feature/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:blindside/feature/dashboard/presentation/widget/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardProvider>(
      onModelReady: (p0) => p0.setPermission(),
      builder: (context, model, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: model.busy
                  ? const CircularProgressIndicator()
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(
                            'My Videos',
                            fontSize: 35,
                            color: AppColors.blackColor70,
                          ),
                          const Gap(32),
                          if (model.assets.isNotEmpty)
                            ...List.generate(
                              model.assets.length,
                              (index) =>
                                  AssetThumbnail(asset: model.assets[index]),
                            )
                          else
                            Column(
                              children: [
                                Center(
                                  child: TextBold('No Videos'),
                                ),
                              ],
                            )
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
