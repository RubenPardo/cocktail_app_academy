import 'package:cocktail_app_academy/data/model/drink_info.dart';
import 'package:equatable/equatable.dart';

abstract class DrinkInfoEvent extends Equatable{}

class DrinkInfoInit extends DrinkInfoEvent{
  final String idDrink;

  DrinkInfoInit(this.idDrink);

  @override
  List<Object?> get props => [idDrink];
}

