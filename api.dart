import 'dart:convert';

import 'package:http/http.dart';

class Api{
  String _handle;
  var m;
  var arr;
  var verdict;
  var rating;

  Api(String handle){
    _handle = handle;
    m = new Map<String, int>();
    verdict = new Map<String, int>();
    rating = new Map<int, int>();
  }

  Future<void> getInfo() async {
    try{
      Response res = await get('https://codeforces.com/api/user.status?handle=$_handle&from=1&count=10');
      Map data = jsonDecode(res.body);
      arr = data['result'];

      if(arr.length > 0){
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

        for(int i = 0; i < arr.length; i++){
          if(verdict.containsKey(arr[i]['verdict'])) verdict[arr[i]['verdict']] += 1;
          else verdict[arr[i]['verdict']] = 1;
        }

        print(m);
        print(verdict);
      }else{
        m = {};
        verdict = {};
        print(m);
        print(verdict);
      }

      Response res_rat = await get('https://codeforces.com/api/user.rating?handle=$_handle  ');
      Map data_rat = jsonDecode(res_rat.body);
      arr = data_rat['result'];

      if(arr.length > 0){
        for(int i = 0; i < arr.length; i++){
          rating[i] = arr[i]['newRating'] ;
        }
      }else{
        rating = {};
      }

    }catch(e){
      print('Caught error: $e');
    }
  }
}
