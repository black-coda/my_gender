import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/tips/controllers/tips_controller.dart';
import 'package:my_gender/tips/model/tip_model.dart';
import 'package:my_gender/utils/constants/konstant.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoTipsScreen extends ConsumerWidget {
  const VideoTipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(getVideoTipsStateNotifierProvider);
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
                      child: VideoCard(
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
  }
}

class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.tipsVideoModel,
  });

  final TipsVideoModel tipsVideoModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          // height: MediaQuery.of(context).size.height * 0.1,
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: tipsVideoModel.thumbnail.startsWith('data:image')
                        ? MemoryImage(
                            base64Decode(
                                tipsVideoModel.thumbnail.split(',')[1]),
                          )
                        : NetworkImage(
                            tipsVideoModel.thumbnail,
                          ),
                  )),
              width: 120,
            ),
            title: Text(tipsVideoModel.title,
                style: Theme.of(context).textTheme.bodyLarge),
            subtitle: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(tipsVideoModel.source,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary)),
                Konstant.sizedBoxHeight2,
                Text(tipsVideoModel.length,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary))
              ],
            ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
