import 'dart:convert';

import 'package:http/http.dart';

class Api{
  var m;
  var arr;

  Api(){
    m = new Map<String, int>();
  }

  Future<void> getInfo() async {
    try{
      Response res = await get('https://codeforces.com/api/user.status?handle=Fefer_Ivan&from=1&count=10');
      Map data = jsonDecode(res.body);
      arr = data['result'];

      for(int i = 0; i < arr.length; i++){
        var tags = arr[i]['problem']['tags'];
        for(int j = 0; j < tags.length; j++){
          if(m.containsKey(tags[j])){
            m[tags[j]] += 1;
          }else{
            m[tags[j]] = 1;
          }
        }
      }

      print(m);
    }catch(e){
      print('Caught error: $e');
    }
  }
}