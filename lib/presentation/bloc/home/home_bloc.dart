import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:cocktail_app_academy/data/model/drink.dart';
import 'package:cocktail_app_academy/data/services/cocktail_api_service.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_event.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent,HomeState>{
  List<Category> categories = List.empty();
  List<Drink> drinks = List.empty();
  final CocktailApiService _cocktailApiService = CocktailApiServiceImpl();


  HomeBloc() : super (HomeLoading()){

  
    /// init home page
    /// 
    /// get from the api the categories and then the 
    /// drinks from the first category
    /// 
    ///
    on<InitHome>( //----------------------------------
      (event, emit) async{
        emit(HomeLoading());
        
        try{
          
          // TODO pasar a caso de uso
          categories = await _cocktailApiService.getCategories();
          drinks = await _cocktailApiService.getDrinksByCategory(categories.first);

          emit(HomeContentLoaded(drinks,categories));  // -------- return drinks      

        }catch(e){
          print("ERROR: $e");
          emit(HomeError("Error inseperado")); // ----- return error
        }
        
        
      },
    );

    /// filter the drinks by category
    on<FilterByDrinkCategory>( //----------------------------------
      (event, emit) async{
        emit(HomeLoading());
        
        try{
          
          drinks = await _cocktailApiService.getDrinksByCategory(event.category);

          emit(HomeContentLoaded(drinks,categories));  // -------- return drinks      

        }catch(e){
          print("ERROR: $e");
          emit(HomeError("Error inseperado")); // ----- return error
        }
        
        
      },
    );

  }
}