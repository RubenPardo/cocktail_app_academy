import 'package:cocktail_app_academy/data/model/drink_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrinkInfoPage extends StatefulWidget {
  final DrinkInfo drinkInfo;
  final String heroTag;
  const DrinkInfoPage({super.key, required this.drinkInfo, required this. heroTag});

  @override
  State<DrinkInfoPage> createState() => _DrinkInfoPageState();
}

class _DrinkInfoPageState extends State<DrinkInfoPage> {

  late ScrollController _scrollController;
   // how big will be the expanded section of the app bar, it 0 because we can not 
   // obtain the size of the screen here either in the init state. It is setted on build
  double kExpandedHeight = 0;

  @override
  void initState() {
    super.initState();
    // al parercer hay que hacer set state cuando se hace scroll
    // para que ek _isSliverAppBarExpanded se actualize
    _scrollController = ScrollController()..addListener(() {setState(() {});});
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight*1.4;
  }

  @override
  Widget build(BuildContext context) {
   kExpandedHeight = MediaQuery.of(context).size.height*0.35;
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
                      ),
                    ),
                childCount: 10),
          )

        ],
      )
    );
  }
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
            background: Image.network(widget.drinkInfo.strDrinkThumb,fit: BoxFit.cover,),
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
}