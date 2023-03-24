import 'package:cocktail_app_academy/core/request.dart';
import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:cocktail_app_academy/data/model/drink.dart';
import 'package:cocktail_app_academy/data/model/drink_info.dart';

abstract class CocktailApiService{

  /// get all the drink categories of the cocktail api
  Future<List<Category>> getCategories();
  /// get all drinks by category
  Future<List<Drink>> getDrinksByCategory(Category category);
  Future<DrinkInfo> getRandomDrink();
  Future<DrinkInfo>getDrinkInfoById(String idDrink);
  


}

class CocktailApiServiceImpl extends CocktailApiService{

  final Request _request = Request();

  @override
  Future<List<Category>> getCategories() async{
    var apiResponse = await _request.get('list.php?c=list');
    if(apiResponse.statusCode == 200){
      return (apiResponse.data['drinks'] as List).map((json) => Category.fromJson(json)).toList();
    }else{
      throw Exception("Error en CocktailApiService getCategories. StatusCode: ${apiResponse.statusCode} Data: ${apiResponse.data}");
    }
  }

  @override
  Future<List<Drink>> getDrinksByCategory(Category category) async{
    var apiResponse = await _request.get('filter.php?c=${category.name}');
    if(apiResponse.statusCode == 200){
      return (apiResponse.data['drinks'] as List).map((json) => Drink.fromJson(json)).toList();
    }else{
      throw Exception("Error en CocktailApiService getDrinksByCategory. StatusCode: ${apiResponse.statusCode} Data: ${apiResponse.data}");
    }
  }
  
  @override
  Future<DrinkInfo> getRandomDrink() async{
    var apiResponse = await _request.get('random.php');
    if(apiResponse.statusCode == 200){
      return DrinkInfo.fromJson((apiResponse.data['drinks'] as List)[0]);
    }else{
      throw Exception("Error en CocktailApiService getDrinksByCategory. StatusCode: ${apiResponse.statusCode} Data: ${apiResponse.data}");
    }
  }
  
  @override
  Future<DrinkInfo> getDrinkInfoById(String idDrink) async{
    var apiResponse = await _request.get('lookup.php?i=$idDrink');
    if(apiResponse.statusCode == 200){
      return DrinkInfo.fromJson((apiResponse.data['drinks'] as List)[0]);
    }else{
      throw Exception("Error en CocktailApiService getDrinksByCategory. StatusCode: ${apiResponse.statusCode} Data: ${apiResponse.data}");
    }
  }

}