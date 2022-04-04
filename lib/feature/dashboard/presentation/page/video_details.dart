// ignore_for_file: unawaited_futures

import 'dart:io';

import 'package:blindside/app/shared/colors.dart';
import 'package:blindside/app/shared/fonts.dart';
import 'package:blindside/app/shared/ui_helpers.dart';
import 'package:blindside/app/view/base_view.dart';
import 'package:blindside/app/widget/input_field.dart';
import 'package:blindside/feature/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:blindside/feature/dashboard/presentation/widget/video_widget.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key? key,
    required this.videoFile,
  }) : super(key: key);

  final Future<File?> videoFile;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool initialized = false;
  bool isDisabled = false;

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initVideo() async {
    final video = await widget.videoFile;
    // _controller = VideoPlayerController.file(video!)
    // Play the video again when it ends
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )
      ..setLooping(true)
      // initialize the controller and notify UI when done
      ..initialize().then((_) => setState(() => initialized = true));
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 14 / 9,
      autoInitialize: true,
      showControlsOnInitialize: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<DashboardProvider>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.blackColor10,
          appBar: AppBar(
            backgroundColor: AppColors.greenColor50,
            title: TextBold(
              'Video detail',
              color: Colors.white,
            ),
            elevation: 0,
          ),
          body: initialized
              // If the video is initialized, display it
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: Chewie(
                              controller: _chewieController,
                            ),
                          ),
                          gapMedium,
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextBold(
                                      'Comments',
                                      color: AppColors.blackColor70,
                                    ),
                                    CupertinoSwitch(
                                      activeColor: AppColors.greenColor50,
                                      value: isDisabled,
                                      onChanged: (value) {
                                        setState(() {
                                          isDisabled = !isDisabled;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                gapSmall,
                                InputField(
                                  controller: null,
                                  isReadOnly: isDisabled,
                                  placeholder: 'Write a comment',
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (value) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                ),
                                ...List.generate(
                                  3,
                                  (index) => const CommentWidget(),
                                ),
                                gapMedium,
                                TextBold(
                                  'Related video',
                                  color: AppColors.blackColor70,
                                ),
                                gapSmall,
                                SizedBox(
                                  width: double.infinity,
                                  height: 250,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) =>
                                        AssetThumbnail(
                                      asset: model.assets[index],
                                      isHorizontal: true,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )

              // If the video is not yet initialized, display a spinner
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.blueColor70,
            child: TextBold(
              'CY',
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          gapSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBold(
                  'Cyril ',
                  fontSize: 15,
                ),
                TextRegular(
                  'I really love everything you have done to explain this video to me I really Like ',
                  color: AppColors.blackColor70,
                  fontSize: 10,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
