import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  int score = 0;

  @override
  GameState get initialState => GameInitial(
        grid: [
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0],
          [0, 0, 0, 0]
        ],
        score: 0,
      );

  @override
  Stream<GameState> mapEventToState(
    GameEvent event,
  ) async* {
    if (event is NewGameStarted) {
      yield* _mapNewGameStartedToState();
    } else if (event is SwipeLeft) {
      yield* _mapSwipeLeftToState(state.grid);
    } else if (event is SwipeRight) {
      yield* _mapSwipeRightToState(state.grid);
    } else if (event is SwipeUp) {
      yield* _mapSwipeUpToState(state.grid);
    } else if (event is SwipeDown) {
      yield* _mapSwipeDownToState(state.grid);
    }
  }

  List<List<int>> _newGameTilesgenerate() {
    List<List<int>> grid = [
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0],
      [0, 0, 0, 0]
    ];
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid.length; j++) {
        grid[i][j] = _generateRandomStartTile();
      }
    }
    return grid;
  }

  int _generateRandomStartTile() {
    var random = Random();
    var randomNumer = random.nextInt(99);
    if (randomNumer <= 84) {
      return 0;
    } else {
      return 2;
    }
  }

  List<List<int>> _generateNewTiles(List<List<int>> grid) {
    for (var i = 0; i < grid.length; i++) {
      for (var j = 0; j < grid.length; j++) {
        if (grid[i][j] == 0) {
          grid[i][j] = _generateRandomStartTile();
        }
      }
    }
    return grid;
  }

  List<List<int>> _swipeNumbersToEdge(List<List<int>> oldGrid) {
    List<List<int>> newGrid = oldGrid;
    for (var x = 0; x < 3; x++) {
      for (var i = 0; i < newGrid.length; i++) {
        for (var j = 0; j < newGrid.length - 1; j++) {
          if (newGrid[i][j] == 0) {
            newGrid[i][j] = newGrid[i][j + 1];
            newGrid[i][j + 1] = 0;
          } else if (newGrid[i][j] == newGrid[i][j + 1]) {
            newGrid[i][j] = newGrid[i][j] * 2;
            score += newGrid[i][j];
            newGrid[i][j + 1] = 0;
          }
        }
      }
    }
    return newGrid;
  }

  List<List<int>> _rotateGridby90DegreesLeft(List<List<int>> oldGrid) {
    List<List<int>> newGrid = oldGrid;
    for (int x = 0; x < 4 / 2; x++) {
      for (int y = x; y < 4 - x - 1; y++) {
        int temp = newGrid[x][y];
        newGrid[x][y] = newGrid[y][4 - 1 - x];
        newGrid[y][4 - 1 - x] = newGrid[4 - 1 - x][4 - 1 - y];
        newGrid[4 - 1 - x][4 - 1 - y] = newGrid[4 - 1 - y][x];
        newGrid[4 - 1 - y][x] = temp;
      }
    }
    return newGrid;
  }

  Stream<GameState> _mapNewGameStartedToState() async* {
    List<List<int>> grid = _newGameTilesgenerate();
    score = 0;
    yield UpdatedGridState(grid: grid, score: 0);
    print(grid);
  }

  Stream<GameState> _mapSwipeLeftToState(grid) async* {
    _swipeNumbersToEdge(grid);
    _generateNewTiles(grid);
    yield UpdatedGridState(grid: grid, score: score);
  }

  Stream<GameState> _mapSwipeRightToState(grid) async* {
    _rotateGridby90DegreesLeft(grid);
    _rotateGridby90DegreesLeft(grid);
    _swipeNumbersToEdge(grid);
    _generateNewTiles(grid);
    _rotateGridby90DegreesLeft(grid);
    _rotateGridby90DegreesLeft(grid);
    yield UpdatedGridState(grid: grid, score: score);
  }

  Stream<GameState> _mapSwipeUpToState(grid) async* {
    _rotateGridby90DegreesLeft(grid);
    _swipeNumbersToEdge(grid);
    _generateNewTiles(grid);
    _rotateGridby90DegreesLeft(grid);
    _rotateGridby90DegreesLeft(grid);
    _rotateGridby90DegreesLeft(grid);
    yield UpdatedGridState(grid: grid, score: score);
  }

  Stream<GameState> _mapSwipeDownToState(grid) async* {
    _rotateGridby90DegreesLeft(grid);
    _rotateGridby90DegreesLeft(grid);
    _rotateGridby90DegreesLeft(grid);
    _swipeNumbersToEdge(grid);
    _generateNewTiles(grid);
    _rotateGridby90DegreesLeft(grid);
    yield UpdatedGridState(grid: grid, score: score);
  }
}
