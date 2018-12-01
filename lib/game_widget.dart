import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';

import 'package:flutter_bird/data/intents.dart';
import 'package:flutter_bird/data/game_state.dart';
import 'package:flutter_bird/nodes/main_game.dart';
// import 'package:flutter_bird/widgets/game_overlay.dart';

class GameWidget extends StatefulWidget {

  GameWidget();

  State<GameWidget> createState() =>  _GameWidgetState();

}

class _GameWidgetState extends State<GameWidget> {

  // This must be initialized outside of the build method.
  final _mainNode = MainGameNode(endGame: Intents.endGame);

  @override
  void initState() {
    super.initState();
    gameObservable.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SpriteWidget(_mainNode),
        gs.status == GameStatus.PLAYING ? Container() : Center(
          child: RaisedButton(
            padding: EdgeInsets.all(8.0),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Intents.startGame();
            },
            child: Text(
              'Play Game',
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 32.0),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.only(top: 4, left: 8),
            child: Text(
              gs.score.toString(),
              style: Theme.of(context).textTheme.body1.copyWith(fontSize: 28.0),
            ),
          ),
        ),
      ]
    );
  }

}
