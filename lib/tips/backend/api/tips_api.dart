import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:my_gender/tips/constant/tips_konstant.dart';
import 'package:my_gender/tips/model/tip_model.dart';

class TipsApi {
  final Dio _dio;

  TipsApi({required Dio dio}) : _dio = dio;

  // get video tips
  Future<Response> getVideoTips() async {
    try {
      final response = await _dio.get(
        TipsApiKonstant.videoBaseEndpoint,
        queryParameters: TipsApiKonstant.videoBaseParams,
      );

      // log(response.data.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // get articles tips

  Future<Response> getArticlesTips() async {
    try {
      final response = await _dio.get(
        TipsApiKonstant.articlesBaseEndpoint,
        queryParameters: TipsApiKonstant.articlesBaseParams,
      );
      log(response.data.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
