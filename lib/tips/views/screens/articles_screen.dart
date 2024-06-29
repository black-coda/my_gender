import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/tips/controllers/tips_controller.dart';
import 'package:my_gender/tips/model/tip_model.dart';
import 'package:my_gender/tips/views/widget/article_display_widget.dart';
import 'package:my_gender/utils/constants/konstant.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleTipsScreen extends ConsumerWidget {
  const ArticleTipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(getArticlesFutureProvider);

    return Scaffold(
      body: articles.when(
        data: (List<TipsArticleModel> article) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Konstant.sizedBoxHeight16,
                  Text("Demystifying Your Period",
                      style: Theme.of(context).textTheme.headlineMedium),
                  Konstant.sizedBoxHeight16,
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: article.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse(article[index].link);
                          await launchUrl(url);
                        },
                        child: ArticleDisplayWidget(
                          title: article[index].title,
                          subtitle: article[index].snippet,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        loading: () {
          return const Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: LinearProgressIndicator(),
          ));
        },
        error: (Object error, StackTrace stackTrace) {
          return Center(
            child: Text(
              error.toString(),
            ),
          );
        },
      ),
    );
  }
}
