import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:cocktail_app_academy/data/model/drink.dart';
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
