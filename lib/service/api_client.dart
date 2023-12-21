import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

class Apis {
  static const API_BASE_URL ="https://api.openweathermap.org/data/2.5/onecall?APPID=af8ad0e5355d3663811f375e4dc0b182";
}

RestClient getApi() {
  final client = RestClient(Dio(), baseUrl: Apis.API_BASE_URL);
  return client;
}

@RestApi(baseUrl: Apis.API_BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio,{String? baseUrl}){
    dio.options = BaseOptions(receiveTimeout: 0,connectTimeout: 0);
    return _RestClient(dio,baseUrl :baseUrl);
  }

  @GET("{query_param}")
  Future<HttpResponse> fetchCurrentAndForecast(
    @Path("query_param") String? url
  );

}

