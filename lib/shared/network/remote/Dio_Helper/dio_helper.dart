import 'package:dio/dio.dart';
import 'package:shop/shared/network/remote/Dio_Helper/endpoints/endpoints.dart';

class DioHelper{
  static late Dio dio;
  static void init(){
    dio=Dio(
      BaseOptions(
        baseUrl:Endpoints.baseUrl,
        receiveDataWhenStatusError: true,
      )
    );
  }
  static Future<Response>getData({required String path,
    Map<String,dynamic>?query
    ,String? lang='en',
    String? token })async{
    dio.options.headers= {
      'Content-Type':'application/json',
    'lang':lang,
    'Authorization':token
    };
    return await dio.get(path,queryParameters: query);
  }
  static Future<Response>postData({required String path,
    required Map<String,dynamic>body,
    Map<String,dynamic>?query,
  String? lang='en',
  String? token,
  }) async{
    dio.options.headers={
      'Content-Type':'application/json',
    'lang':lang,
    'Authorization':token
    };
    return await dio.post(path,data: body,queryParameters: query);
}
static Future<Response>putData({required String path,
  required Map<String,dynamic>body,
  Map<String,dynamic>?query,
  String? lang='en',
String? token
})async{
dio.options.headers={
  'Content-Type':'application/json',
  'lang':lang,
  'Authorization':token
};
return await dio.put(path,data: body,queryParameters: query);
}

}