import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_2048/bloc/game_bloc.dart';
import 'package:swipedetector/swipedetector.dart';

import 'game_tiles.dart';
import 'score_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameBloc(),
      child: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {},
        builder: (context, state) {
          var grid = state.grid;
          return Scaffold(
            backgroundColor: Color(0xffeee4da),
            body: SwipeDetector(
              onSwipeLeft: () {
                BlocProvider.of<GameBloc>(context).add(SwipeLeft(grid));
              },
              onSwipeRight: () {
                BlocProvider.of<GameBloc>(context).add(SwipeRight(grid));
              },
              onSwipeUp: () {
                BlocProvider.of<GameBloc>(context).add(SwipeUp(grid));
              },
              onSwipeDown: () {
                BlocProvider.of<GameBloc>(context).add(SwipeDown(grid));
              },
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '2048',
                          style: TextStyle(
                            color: const Color(0xff766d67),
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FlatButton(
                          color: const Color(0xffbcac9f),
                          onPressed: () {
                            BlocProvider.of<GameBloc>(context).add(
                              NewGameStarted(),
                            );
                          },
                          child: Text(
                            'New Game',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff766d67),
                            ),
                          ),
                        ),
                        ScoreWidget(state.score),
                      ],
                    ),
                    
                       GameTiles(grid: grid),
                    
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
