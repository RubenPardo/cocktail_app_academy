import 'package:cocktail_app_academy/data/model/drink_info.dart';
import 'package:cocktail_app_academy/presentation/bloc/drink_info/drink_info_bloc.dart';
import 'package:cocktail_app_academy/presentation/bloc/drink_info/drink_info_event.dart';
import 'package:cocktail_app_academy/presentation/bloc/drink_info/drink_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrinkInfoPage extends StatefulWidget {
  DrinkInfo drinkInfo;
  final String heroTag;
  final bool loadMoreInfo;
  DrinkInfoPage({super.key, required this.drinkInfo, required this. heroTag, this.loadMoreInfo = true});

  @override
  State<DrinkInfoPage> createState() => _DrinkInfoPageState();
}

class _DrinkInfoPageState extends State<DrinkInfoPage> {

  late ScrollController _scrollController;
   // how big will be the expanded section of the app bar, it 0 because we can not 
   // obtain the size of the screen here either in the init state. It is setted on build
  double kExpandedHeight = 0;

  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    // al parercer hay que hacer set state cuando se hace scroll
    // para que ek _isSliverAppBarExpanded se actualize
    _scrollController = ScrollController()..addListener(() {setState(() {});});

    _isLoading = widget.loadMoreInfo;
    if(widget.loadMoreInfo){
      context.read<DrinkInfoBloc>().add(DrinkInfoInit(widget.drinkInfo.idDrink));
    }
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight*1.4;
  }

  

  @override
  Widget build(BuildContext context) {
   kExpandedHeight = MediaQuery.of(context).size.height*0.35;
    return BlocConsumer<DrinkInfoBloc,DrinkInfoState>(
      builder: (context, state) {
       return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [

              _appBar(),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 75,
                            color: Colors.black12,
                            child: _isLoading ? const SizedBox() : Text(widget.drinkInfo.strInstructions!.isNotEmpty ? widget.drinkInfo.strInstructions! : "No instruccions"),
                          ),
                        ),
                    childCount: 10),
              )

            ],
          )
        );
      }, 
      listener: (context, state) {
        if(state is DrinkInfoLoading){
            startLoading();
            
            setState(() {
              _isLoading = true;
            });
          
          // if is other state other than loading and it was loading stop it
          }else if(_isLoading){
            setState(() {
              _isLoading = false;
            });
            stopLoading();
          }

        if(state is DrinkInfoLoaded){
          setState(() {
            widget.drinkInfo = state.drinkInfo;
          });
        }
      },
    );
  }
  
  /// return a sliver appbar
  Widget _appBar(){
    return SliverAppBar(
      pinned: true,
      iconTheme: const IconThemeData(color: Colors.white),
      expandedHeight: kExpandedHeight,
      title: AnimatedOpacity(
        opacity: _isSliverAppBarExpanded ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Text(widget.drinkInfo.strDrink),
      ),
      flexibleSpace:  FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(0),
            background: Hero(
              tag: widget.heroTag,
              child: Image.network(widget.drinkInfo.strDrinkThumb,fit: BoxFit.cover,),
            ),
            title: AnimatedOpacity(
              opacity: _isSliverAppBarExpanded ? 0 : 1,
              duration: const Duration(milliseconds: 100),
              child: Container(
                  width: double.infinity,
                  decoration:  const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0, 0), // bottom
                              end: Alignment(0, -1), // top
                              colors: [
                                Color.fromARGB(173, 0, 0, 0),
                                Colors.transparent
                              ]
                            )
                          ),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(widget.drinkInfo.strDrink,),
                    ),
                ),
            ),
          ),
      
      
       
      
    );
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