import 'package:flutter/material.dart';
import 'package:game_2048/tile.dart';

class GameTiles extends StatelessWidget {
  List<List<int>> grid;

  GameTiles({
    Key key,
    this.grid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: const Color(0xffbbada1),
      ),
      margin: EdgeInsets.all(4),
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 16,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, int index) {
          int x = (index / 4).floor();
          int y = (index % 4);
          return Tile(
            number: grid[x][y],
          );
        },
      ),
    );
  }
}
