import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

class Apis {
  static const API_BASE_URL ="https/";

}

@RestApi(baseUrl: Apis.API_BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio,{String? baseUrl}){
    dio.options = BaseOptions(receiveTimeout: 0,connectTimeout: 0);
    return _RestClient(dio,baseUrl :baseUrl);
  }
}

