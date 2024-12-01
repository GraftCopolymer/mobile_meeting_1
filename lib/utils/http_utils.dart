import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HttpUtils{
  static final BASE_URL = "http://www.graftcopolymer.love/mobile";

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL
    )
  );

  static Future<Response> request(
    String path, String method, {
    Object? data, 
    Map<String, dynamic>? queryParameters, 
    Options? options, 
    CancelToken? cancelToken, void Function(int,int)? onReceiveProgress}) async{
    try{
      Options requestOptions = options ?? Options();
      Response res = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: requestOptions.copyWith(method: method),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress
      );
      return res;
    } on DioException catch (e){
      debugPrint("$e");
      // 将错误中的信息返回
      return Response(requestOptions: e.requestOptions);
    }
  }

  static Future<Response> get(
    String path, {
    Object? data, 
    Map<String, dynamic>? queryParameters, 
    Options? options, 
    CancelToken? cancelToken}) async{
      
    Response res = await request(
      path, "GET", 
      data: data, 
      queryParameters: queryParameters, 
      options: options, 
      cancelToken: cancelToken
    );
    return res;
  }

  static Future<Response> post(
    String path, {
    Object? data, 
    Map<String, dynamic>? queryParameters, 
    Options? options, 
    CancelToken? cancelToken}) async{
      
    Response res = await request(
      path, "POST", 
      data: data, 
      queryParameters: queryParameters, 
      options: options, 
      cancelToken: cancelToken
    );
    return res;
  }

  static Future<Response> getRandomComment() async {
    Response res = await get("/comment/getRandomComment");
    return res;
  }

  static Future<Response> getRandomImage() async {
    Response res = await get("/image/getRandomImage");
    return res;
  }

  static Future<Response> uploadComment(String content) async {
    Response res = await get("/comment/uploadComment", queryParameters: {
      "content": content
    });
    return res;
  }

  static Future<Response> uploadImage(File file) async {
    String imageType = file.path.substring(file.path.lastIndexOf(".")+1);
    print(imageType);
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, contentType: DioMediaType("image", imageType))
    });
    Response res = await post("/image/uploadImage", data: formData);
    return res;
  }
}