class Drink {
  String strDrink;
  String strDrinkThumb;
  String idDrink;

  Drink(this.strDrink, this.strDrinkThumb, this.idDrink);

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      json['strDrink'] ?? "",
      json['strDrinkThumb'] ?? "",
      json['idDrink'] ?? ""
    );
  }

  factory Drink.dummy() {
    return Drink.fromJson({
      "strDrink": "155 Belmont",
      "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/yqvvqs1475667388.jpg",
      "idDrink": "15346"
    });
  }
}