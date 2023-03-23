import 'package:cocktail_app_academy/data/model/category.dart';
import 'package:cocktail_app_academy/data/model/drink.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_bloc.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_event.dart';
import 'package:cocktail_app_academy/presentation/bloc/home/home_state.dart';
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

  @override
  void initState() {
    context.read<HomeBloc>().add(InitHome());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocConsumer<HomeBloc,HomeState>(
        builder: (context, state) {
          
            if(state is HomeLoading){
              return const Center(child: CircularProgressIndicator(),);
            }

            return _body();
            
          
        },
        listener: (context, state) {
          if(state is HomeContentLoaded){
            setState(() {
              _drinks = state.drinks;
              _categories = state.categories;
              if(_searchTextController.text.isNotEmpty){
                _filterDrinksByName(_searchTextController.text);
              }
            });
          }
        },
      ),
    );
  }

  /// return the body of the home page
  Widget _body(){
    if(_drinks.isEmpty){
      return const Center(child: Text("No drinks"),);
    }else{
      return GridView.builder(
        shrinkWrap: true,
        itemCount: _drinks.length,
        itemBuilder: (context, i) => DrinkWidget(drink: _drinks[i],), 
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 1
          
        ),
      );
    }
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
        context.read<HomeBloc>().add(FilterByDrinkCategory(value));
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
}