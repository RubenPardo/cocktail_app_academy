import 'drink.dart';

class DrinkInfo extends Drink{

  DrinkInfo(super.strDrink, super.strDrinkThumb, super.idDrink);

  factory DrinkInfo.fromDrink(Drink drink) {
    return DrinkInfo(drink.strDrink, drink.strDrinkThumb, drink.idDrink);
  }

  factory DrinkInfo.fromJson(Map<String,dynamic?> json) {
    return DrinkInfo(
      json['strDrink'] ?? "",
      json['strDrinkThumb'] ?? "",
      json['idDrink'] ?? ""
    );
  }
  
}