import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

class Apis {
  static const API_BASE_URL ="https://api.openweathermap.org/data/2.5/onecall?APPID=335cc08fb177116a777add4eac3f312b";
}

RestClient getApi({bool isLogEnable = true}) {
  final client = RestClient(Dio(), baseUrl: Apis.API_BASE_URL,isLogEnable: isLogEnable,);
  return client;
}

@RestApi(baseUrl: Apis.API_BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio,{String? baseUrl, bool isLogEnable = true}){
    dio.options = BaseOptions(receiveTimeout: 0,connectTimeout: 0);
    if (isLogEnable && kDebugMode) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return _RestClient(dio,baseUrl :baseUrl);
  }

  @GET("{query_param}")
  Future<HttpResponse> fetchCurrentAndForecast(
    @Path("query_param") String? url
  );

}

