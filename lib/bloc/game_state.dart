part of 'game_bloc.dart';

@immutable
abstract class GameState {
  final List<List<int>> grid = [];
  final int score = 0;
}

class GameInitial extends GameState {
  final List<List<int>> grid;
  final int score;

  GameInitial({this.grid, this.score});
}

class UpdatedGridState extends GameState {
  final List<List<int>> grid;
  final int score;

  UpdatedGridState({this.grid, this.score});
}
