import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dioClient= Dio(
  BaseOptions(
    baseUrl: "https://stuverse.shop/api"
  )
);