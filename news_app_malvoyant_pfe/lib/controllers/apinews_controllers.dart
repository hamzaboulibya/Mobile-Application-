import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/newsapi_model.dart';

class NewsAPIControllers extends GetxController {
  var isCacheExist;
  getData() async {
    final url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=ma&apiKey=6d002750a3bb4588a27e848db63a7309");
    isCacheExist = await APICacheManager().isAPICacheKeyExist("API_News");
    if (!isCacheExist) {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        try {
          APICacheDBModel cacheDBModel = new APICacheDBModel(key:  "API_News", syncData: response.body);

          print("URL : HERE");
          await APICacheManager().addCacheData(cacheDBModel);
          return Articles.fromJson(jsonDecode(response.body));
        }
        catch (e) {
          Get.snackbar("error", e.toString());
        }
      }
    }
    else{
      APICacheManager().deleteCache("API_News");
      http.Response response =  await http.get(url);
      if(response.statusCode== 200){
        try{
          APICacheDBModel cacheDBModel = new APICacheDBModel(key:  "API_News", syncData: response.body);

          print("URL : HERE");
          await APICacheManager().addCacheData(cacheDBModel);
          return Articles.fromJson(jsonDecode(response.body));
        }
        catch(e){
          Get.snackbar("error", e.toString());
        }
      }
    }
  }
  getDataOffline() async{
    isCacheExist =await APICacheManager().isAPICacheKeyExist("API_News");
    if(!isCacheExist){
      getData();
    }
    else{
    var cacheDate = await APICacheManager().getCacheData("API_News");
    print("CACHE : HERE");
    return Articles.fromJson(jsonDecode(cacheDate.syncData));
    }
  }
}