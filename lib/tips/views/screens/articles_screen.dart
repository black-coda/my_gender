import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/tips/controllers/tips_controller.dart';

class ArticleTipsScreen extends ConsumerWidget {
  const ArticleTipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const Center(
            child: Text('Articles Screen'),
          ),
          TextButton(
              onPressed: () {
                ref.watch(tipsApiProvider).getArticlesTips();
              },
              child: const Text("Fetch"))
        ],
      ),
    ));
  }
}
