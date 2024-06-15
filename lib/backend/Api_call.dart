import 'dart:convert';

import 'package:http/http.dart' as http;


class APICall{
  Future<List>fetchnNew(String newTypes) async {
    String key='a69c59a26568473492f67ee44c312db0';
    final response=await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&category='+newTypes+'&pageSize=100&apiKey=$key'));
    Map result=jsonDecode(response.body);
    print({result['articles']});
    return (result['articles']??[]);
  }
}