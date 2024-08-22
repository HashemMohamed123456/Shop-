import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static  SharedPreferences? prefs;
  static Future<void>init()async{
    prefs= await SharedPreferences.getInstance();
  }
  static Future<bool>? setData({required String key, required dynamic value}){
    if(value is String){
      prefs?.setString(key, value);
    }else if(value is int){
      prefs?.setInt(key, value);
    }else if(value is double){
      prefs?.setDouble(key, value);
    }else if(value is bool){
      prefs?.setBool(key, value);
    }else{
      prefs?.setStringList(key, value);
    }
    return null;
  }
  static dynamic getData({required String key}){
    return prefs?.get(key);
  }
  static Future<bool?>? removeData({required String key})async{
    return await prefs?.remove(key);
  }
  static void clearData(){
    prefs?.clear();
  }
}