import 'package:cocktail_app_academy/data/model/drink.dart';
import 'package:cocktail_app_academy/data/model/drink_info.dart';
import 'package:cocktail_app_academy/presentation/pages/drink_info_page.dart';
import 'package:cocktail_app_academy/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DrinkWidget extends StatelessWidget {
  final Drink drink;
  final String heroTag;
  const DrinkWidget({super.key, required this.drink, required this.heroTag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

          Navigator.push(context,MaterialPageRoute( builder: (context) =>  DrinkInfoPage(drinkInfo: DrinkInfo.fromDrink(drink),heroTag: heroTag)));
        
      },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(
            boxShadow: [
                 BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15.0,
                  
                    offset: Offset(0.0, 0.75)
                )
              ],
            ),
            child: Stack(
              children: [
                
                Hero(
                  tag: heroTag,
                  child: Image.network(
                    drink.strDrinkThumb,
                    fit: BoxFit.fill,
                  ),
                ),
                // card title
               Align(
                alignment: Alignment.bottomLeft,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0, 0), // bottom
                          end: Alignment(0, -1), // top
                          colors: [
                            Color.fromARGB(173, 0, 0, 0),
                            Colors.transparent
                          ]
                        )
                      ),
                      child: Padding(padding:const EdgeInsets.only(top: 40,bottom: 8,left: 8,right: 8), // padding top bigger to make larger the gradient
                       child: Text(drink.strDrink, style: Styles.cardTitle, maxLines: 2, overflow: TextOverflow.ellipsis,),
                       
                      ),
                    )
                  ),
                
              ],
            )
          ),
        ),
    );
  }
}