import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_gender/tips/backend/api/tips_api.dart';
import 'package:my_gender/tips/model/tip_model.dart';

import 'dio_controller.dart';

class GetVideoTipsNotifier extends StateNotifier<List<TipsVideoModel>> {
  GetVideoTipsNotifier({required this.tipsApi}) : super([]);

  final TipsApi tipsApi;
  bool isLoading = false;

  Future<bool> getTipsVideo() async {
    isLoading = true;
    final Response response = await tipsApi.getVideoTips();
    if (response.statusCode != 200 ||
        response.data == null ||
        response.data.isEmpty) {
      isLoading = false;
      return false;
    }

    final videos = response.data['videos'] as List;

    final List<TipsVideoModel> tips =
        videos.map((e) => TipsVideoModel.fromMap(e)).toList();
    isLoading = false;
    state = tips;
    return true;
  }

  Future<void> getTipsVideos() async {
    final Response response = await tipsApi.getVideoTips();
    if (response.statusCode != 200 ||
        response.data == null ||
        response.data.isEmpty) {}

    final videos = response.data['videos'] as List;

    final List<TipsVideoModel> tips =
        videos.map((e) => TipsVideoModel.fromMap(e)).toList();

    state = tips;
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

final getVideosFutureProvider = FutureProvider<void>((ref) async {
  final videos =
      ref.watch(getVideoTipsStateNotifierProvider.notifier).getTipsVideos();
  return videos;
});
