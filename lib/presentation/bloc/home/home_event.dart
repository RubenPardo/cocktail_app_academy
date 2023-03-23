import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable{}

class InitHome extends HomeEvent{
  @override
  List<Object?> get props => [];
}

class FilterByDrinkName extends HomeEvent{
  final String name;
  FilterByDrinkName(this.name);
  @override
  List<Object?> get props => [name];
}

class FilterByDrinkCategory extends HomeEvent{
  final Category category;
  FilterByDrinkCategory(this.category);
  @override
  List<Object?> get props => [category];
}