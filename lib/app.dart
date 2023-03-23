import 'package:cocktail_app_academy/presentation/bloc/home/home_bloc.dart';
import 'package:cocktail_app_academy/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()), 
      ],
      child:  MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.greenAccent
        ),
        title: 'Login App',
        debugShowCheckedModeBanner: false,
        home: const HomePage()
      )
    );
  }
}