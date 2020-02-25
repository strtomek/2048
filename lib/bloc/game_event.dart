part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class NewGameStarted extends GameEvent {}

class SwipeLeft extends GameEvent {
  final List<List<int>> grid;

  SwipeLeft(this.grid);
}

class SwipeRight extends GameEvent {
  final List<List<int>> grid;

  SwipeRight(this.grid);
}

class SwipeUp extends GameEvent {
  final List<List<int>> grid;

  SwipeUp(this.grid);
}

class SwipeDown extends GameEvent {
  final List<List<int>> grid;

  SwipeDown(this.grid);
}
