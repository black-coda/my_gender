import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/tips/controllers/tips_controller.dart';
import 'package:my_gender/tips/views/screens/articles_screen.dart';
import 'package:my_gender/tips/views/screens/video_screen.dart';
import 'package:my_gender/utils/constants/strings.dart';

import 'widget/tab_item.dart';

class TipsView extends ConsumerStatefulWidget {
  const TipsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TipsViewState();
}

class _TipsViewState extends ConsumerState<TipsView> {
  @override
  void initState() {
    super.initState();
    ref.read(getVideoTipsStateNotifierProvider.notifier).getTipsVideo();
  }

  @override
  Widget build(BuildContext context) {
    final List videos = ref.watch(getVideoTipsStateNotifierProvider);
    final isLoading =
        ref.watch(getVideoTipsStateNotifierProvider.notifier).isLoading;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicator: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black54,
                        tabs: [
                          const TabItem(title: Strings.articles, count: 6),
                          TabItem(title: Strings.videos, count: videos.length),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: TabBarView(
                  children: [
                    ArticleTipsScreen(),
                    VideoTipsScreen(),
                  ],
                ),
              ),
            ),
          );
  }
}
