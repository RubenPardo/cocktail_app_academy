import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{}

class InitHome extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class GetRandomDrink extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class FilterByDrinkCategory extends HomeEvent{
  final Category category;
  FilterByDrinkCategory(this.category);
  @override
  List<Object?> get props => [category];
}