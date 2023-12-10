import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:http/http.dart' as http;
import '../models/new_models.dart';
import 'package:get/get.dart';

class NewsControllers{

  String source;
  NewsControllers({required this.source});
  var isCacheExist;
  readJsonApi(String source) async {
    final url=Uri.parse("https://intelligentsofts.com/scrapNews/scrapLeSiteInfo.php?jsonFile=${source}");
    isCacheExist =await APICacheManager().isAPICacheKeyExist("${source}");
    if(!isCacheExist){
      print('azetr khdam ${source}');
      http.Response response =  await http.get(url);
      if(response.statusCode== 200){
        try{
          APICacheDBModel cacheDBModel = new APICacheDBModel(key:  "${source}", syncData: response.body);

          print("URL : HERE");
          await APICacheManager().addCacheData(cacheDBModel);
          return News.fromJson(jsonDecode(response.body));
        }
        catch(e){
          Get.snackbar("error", e.toString());
        }
      }
    }
    else{
      print('azetr khdam ${source}');
      APICacheManager().deleteCache("${source}");
      http.Response response =  await http.get(url);
      if(response.statusCode== 200){
        try{
          APICacheDBModel cacheDBModel = new APICacheDBModel(key:  "${source}", syncData: response.body);

          print("URL : HERE");
          await APICacheManager().addCacheData(cacheDBModel);
          return News.fromJson(jsonDecode(response.body));
        }
        catch(e){
          Get.snackbar("error", e.toString());
        }
      }
    }
  }
  readJsonOffline() async{
    isCacheExist =await APICacheManager().isAPICacheKeyExist("${source}");
    if(!isCacheExist){
      readJsonApi(source);
    }
    else{
      var cacheDate = await APICacheManager().getCacheData("${source}");
      print("CACHE : HERE");
      return News.fromJson(jsonDecode(cacheDate.syncData));
    }

  }
}
