import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:cocktail_app_academy/data/model/drink.dart';
import 'package:cocktail_app_academy/data/model/drink_info.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_bloc.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_event.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_state.dart';
import 'package:cocktail_app_academy/presentation/pages/drink_info_page.dart';
import 'package:cocktail_app_academy/presentation/widgets/drink_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  /// if true make appear the search bar on appbar
  bool _showSearchAppBar = false;

  List<Drink> _drinks = List.empty();
  List<Category> _categories = List.empty();

  final TextEditingController _searchTextController = TextEditingController();

  String _title = "Ordinary Drinks";
  bool _isLoading = false;

  @override
  void initState() {
    
    super.initState();
    context.read<HomeBloc>().add(InitHome());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _fab(),
    );
  }


  /// return the fab that open the drink info page with a random drink
  FloatingActionButton _fab(){
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        context.read<HomeBloc>().add(GetRandomDrink());
      },
    );
  }


  


  
  /// return the body of the home page
  Widget _body(){
    return BlocConsumer<HomeBloc,HomeState>(
        builder: (context, state) {
          
            if(_drinks.isEmpty){
              return const Center(child: Text("No drinks"),);
            }else{
              return GridView.builder(
                shrinkWrap: true,
                itemCount: _drinks.length,
                itemBuilder: (context, i) => DrinkWidget(drink: _drinks[i],heroTag: "drinkImage$i",), 
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 1
                  
                ),
              );
            }
            
          
        },
        listener: (context, state) {
          if(state is HomeLoading){
            startLoading();
            _isLoading = true;
          
          // if is other state other than loading and it was loading stop it
          }else if(_isLoading){
            stopLoading();
          }
          
          if(state is HomeContentLoaded){
            setState(() {
              _drinks = state.drinks;
              _categories = state.categories;
              if(_searchTextController.text.isNotEmpty ){
                _filterDrinksByName(_searchTextController.text);
              }
            });
          }else if(state is HomeRandomDrinkObtained){
            Navigator.push(context,MaterialPageRoute( builder: (context) =>  DrinkInfoPage(drinkInfo: state.drink,heroTag: "",)));

          }
        },
      );

    
  }

  /// return the appbar of home page
  AppBar _appBar(){
    return AppBar(
      title: _showSearchAppBar ? _searchTextField() : Text(_title),
      actions: [
        // show search or close icon
        !_showSearchAppBar 
          ? IconButton(
              onPressed: (){setState(() {_showSearchAppBar = true; });}, 
              icon: const Icon(Icons.search)
            )
          : IconButton(
              onPressed: (){
                setState(() {
                  _showSearchAppBar = false; 
                  _searchTextController.clear();
                  setState(() {
                      _drinks = context.read<HomeBloc>().drinks;
                  });
                });
              }, 
              icon: const Icon(Icons.close)
            ),
           _popUpMenuCategories(),
      ],
    );
  }

  /// returns a popup menus that shows the all the drink categories
  /// click one will get the drinks of that category
  PopupMenuButton _popUpMenuCategories(){
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context){
        return _categories.map((category) => 
          PopupMenuItem(value: category,child: Text(category.name),)
        ).toList();
      },
      onSelected: <Category>(value) {
        setState(() {
          _title = "${value.name}";
        });
        if(mounted){
          //context.read<HomeBloc>().add(FilterByDrinkCategory(value));
        }
      },
    );
  }

  // return a text field that filters the cocktail list
  Widget _searchTextField(){
    return TextField(
      controller: _searchTextController,
      onChanged: (value) {
        // --------------------------------------> 
       _filterDrinksByName(value);
      },
      autofocus: true, //Display the keyboard when TextField is displayed
      style: const TextStyle(
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search, 
      decoration: const InputDecoration( 
        border: InputBorder.none,
        hintText: 'Search drink...', 
        hintStyle: TextStyle( 
          fontSize: 20,
        ),
      ),
    );
  }

  /// filter the array [_drinks] by drink name
  void _filterDrinksByName(String name){
    setState(() {
          _drinks = context.read<HomeBloc>().drinks.where((element) => element.strDrink.toLowerCase().contains(name)).toList();
       });
  }


  /// return a dialog full screen with a progres loading
  Future<void> startLoading() async {
      return await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent, // can change this to your prefered color
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        },
      );
    }

    
  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }
}