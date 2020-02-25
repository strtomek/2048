import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  int number;

  Tile({this.number});

  @override
  Widget build(BuildContext context) {
    Color color = _pickColor(number);

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: const EdgeInsets.all(5),
      width: 80,
      height: 80,
      child: Center(
        child: Text(
          number == 0 ? '' : '$number',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: number == 2 || number == 4
                ? const Color(0xff776e65)
                : Colors.white,
          ),
        ),
      ),
    );
  }

  Color _pickColor(int number) {
    switch (number) {
      case 0:
        return Color(0xffcec1b4);
        break;
      case 2:
        return Color(0xffede4da);
        break;
      case 4:
        return Color(0xffeadfcb);
        break;
      case 8:
        return Color(0xfff0b07a);
        break;
      case 16:
        return Color(0xfff59563);
        break;
      case 32:
        return Color(0xfff67c60);
        break;
      case 64:
        return Color(0xfff65e3b);
        break;
      case 128:
        return Color(0xffedcf73);
        break;
      case 256:
        return Color(0xffedcf73);
        break;
      case 512:
        return Color(0xffedc850);
        break;
      case 1024:
        return Color(0xffedc53f);
        break;
      case 2048:
        return Color(0xffedc22d);
        break;
      case 4096:
        return Color(0xffef676e);
        break;
      case 8192:
        return Color(0xffec4d5a);
        break;
      case 16384:
        return Color(0xffe81e2f);
        break;
      default:
        return Color(0xff9f212c);
    }
  }
}
