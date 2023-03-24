import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:cocktail_app_academy/data/model/drink.dart';
import 'package:cocktail_app_academy/data/model/drink_info.dart';
import 'package:cocktail_app_academy/data/services/cocktail_api_service.dart';
import 'package:cocktail_app_academy/presentation/bloc/drink_info/drink_info_event.dart';
import 'package:cocktail_app_academy/presentation/bloc/drink_info/drink_info_state.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_event.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrinkInfoBloc extends Bloc<DrinkInfoEvent,DrinkInfoState>{
  late DrinkInfo drinkInfo;
  final CocktailApiService _cocktailApiService = CocktailApiServiceImpl();


  DrinkInfoBloc() : super (DrinkInfoInitState()){

  
    /// init drink info page
    /// 
    /// get from the api the info drink by id
    /// 
    ///
    on<DrinkInfoInit>( //----------------------------------
      (event, emit) async{
        emit(DrinkInfoLoading());
        
        try{
          
          drinkInfo = await _cocktailApiService.getDrinkInfoById(event.idDrink);

          emit(DrinkInfoLoaded(drinkInfo));  // -------- return drinks      

        }catch(e){
          print("ERROR: $e");
          emit(DrinkInfoError("Error inseperado")); // ----- return error
        }
        
        
      },
    );

  }
}