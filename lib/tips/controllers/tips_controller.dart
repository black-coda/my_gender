import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/tips/backend/api/tips_api.dart';
import 'package:my_gender/tips/model/tip_model.dart';

import 'dio_controller.dart';

class GetVideoTipsNotifier extends StateNotifier<List<TipsVideoModel>> {
  GetVideoTipsNotifier({required this.tipsApi}) : super([]);

  final TipsApi tipsApi;

  List<TipsArticleModel> articles = [];

  Future<List<TipsVideoModel>> getTipsVideo() async {
    final Response response = await tipsApi.getVideoTips();
    if (response.statusCode != 200 ||
        response.data == null ||
        response.data.isEmpty) {
      return [];
    }

    final videos = response.data['videos'] as List;

    final List<TipsVideoModel> tips =
        videos.map((e) => TipsVideoModel.fromMap(e)).toList();

    state = tips;
    return state;
  }

  Future<List<TipsArticleModel>> getTipsArticles() async {
    final Response response = await tipsApi.getArticlesTips();
    if (response.statusCode != 200 ||
        response.data == null ||
        response.data.isEmpty) {}

    final videos = response.data['organic_results'] as List;

    final List<TipsArticleModel> tips =
        videos.map((e) => TipsArticleModel.fromMap(e)).toList();

    articles = tips;
    return articles;
  }
}

final tipsApiProvider = Provider<TipsApi>((ref) {
  final dio = ref.watch(dioProvider);
  return TipsApi(dio: dio);
});

final getVideoTipsStateNotifierProvider =
    StateNotifierProvider<GetVideoTipsNotifier, List<TipsVideoModel>>((ref) {
  final tipsApi = ref.watch(tipsApiProvider);
  return GetVideoTipsNotifier(tipsApi: tipsApi);
});

final getVideosFutureProvider =
    FutureProvider<List<TipsVideoModel>>((ref) async {
  final videos = await ref
      .watch(getVideoTipsStateNotifierProvider.notifier)
      .getTipsVideo();
  return videos;
});

final getArticlesFutureProvider =
    FutureProvider<List<TipsArticleModel>>((ref) async {
  final articles =
      ref.read(getVideoTipsStateNotifierProvider.notifier).getTipsArticles();
  return articles;
});
