import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:cocktail_app_academy/data/model/drink.dart';
import 'package:cocktail_app_academy/data/model/drink_info.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable{}

class HomeLoading extends HomeState{
  @override
  List<Object?> get props => [];
}
class HomeError extends HomeState{
  final String error;
  HomeError(this.error);
  @override
  List<Object?> get props => [error];
}

class HomeContentLoaded extends HomeState{
  final List<Drink> drinks;
  final List<Category> categories;
  HomeContentLoaded(this.drinks,this.categories);

  @override
  List<Object?> get props => [drinks,categories];
}

class HomeRandomDrinkObtained extends HomeState{
  final DrinkInfo drink;
  HomeRandomDrinkObtained(this.drink);

  @override
  List<Object?> get props => [drink];
}