import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resturent_app/model/dish_model.dart';


const url = 'http://www.mocky.io/v2/5dfccffc310000efc8d2c1ad';
class GetDishes{

Future<List<DishModel>> getlistofdishes() async
{
  http.Response response = await  http.get(url);

  if(response.statusCode ==200)
  {
    Iterable iterable = (json.decode(response.body));
    List<DishModel> disheslist = iterable.map((f) => DishModel.fromJson(f)).toList();
    return disheslist;
  }
  else{
    throw('Error occured');
  }

}

}