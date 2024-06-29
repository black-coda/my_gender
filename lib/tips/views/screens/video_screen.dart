import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/tips/controllers/tips_controller.dart';
import 'package:my_gender/tips/model/tip_model.dart';
import 'package:my_gender/tips/views/widget/video_display_wisget.dart';
import 'package:my_gender/utils/constants/konstant.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoTipsScreen extends ConsumerWidget {
  const VideoTipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(getVideosFutureProvider);
    return videos.when(
      data: (List<TipsVideoModel> videos) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async => ref.refresh(getVideosFutureProvider.future),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Konstant.sizedBoxHeight16,
                    Text("Useful video Tips on Menstrual Hygiene and Education",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Konstant.sizedBoxHeight16,
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final TipsVideoModel video = videos[index];
                        return GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(video.link);
                            await launchUrl(url);
                          },
                          child: VideoCardWidget(
                            tipsVideoModel: video,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: LinearProgressIndicator(),
            ),
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
    );
  }
}

