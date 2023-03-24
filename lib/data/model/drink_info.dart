import 'drink.dart';

class DrinkInfo extends Drink{

  String? strInstructions;

  DrinkInfo(super.strDrink, super.strDrinkThumb, super.idDrink,this.strInstructions);

  factory DrinkInfo.fromDrink(Drink drink) {
    return DrinkInfo(drink.strDrink, drink.strDrinkThumb, drink.idDrink,null);
  }

  factory DrinkInfo.fromJson(Map<String,dynamic> json) {
    return DrinkInfo(
      json['strDrink'] ?? "",
      json['strDrinkThumb'] ?? "",
      json['idDrink'] ?? "",
      json['strInstructions']
    );
  }
  
}