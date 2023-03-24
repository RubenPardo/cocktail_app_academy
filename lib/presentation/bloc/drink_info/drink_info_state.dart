import 'package:cocktail_app_academy/data/model/drink_info.dart';
import 'package:equatable/equatable.dart';

abstract class DrinkInfoState extends Equatable{}

class DrinkInfoLoading extends DrinkInfoState{
  @override
  List<Object?> get props => [];

}


class DrinkInfoInitState extends DrinkInfoState{
  @override
  List<Object?> get props => [];
}

class DrinkInfoLoaded extends DrinkInfoState{

  final DrinkInfo drinkInfo;

  DrinkInfoLoaded(this.drinkInfo);

  @override
  List<Object?> get props => [drinkInfo];
}

class DrinkInfoError extends DrinkInfoState{

  final String error;

  DrinkInfoError(this.error);

  @override
  List<Object?> get props => [error];
}