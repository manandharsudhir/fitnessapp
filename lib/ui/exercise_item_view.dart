import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitnessapp/app/services/model/exercise_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExerciseItemView extends StatefulWidget {
  final ExerciseModel exercise;
  ExerciseItemView({@required this.exercise});

  @override
  _ExerciseItemViewState createState() => _ExerciseItemViewState();
}

class _ExerciseItemViewState extends State<ExerciseItemView> {
  bool _startExercise = false;
  int _elapsedTime = 0;
  Timer timer;
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  void timerFunc() async {
    timer = await Timer.periodic(Duration(seconds: 1), (t) {
      if (_startExercise) {
        if (t.tick == int.parse(widget.exercise.seconds)) {
          t.cancel();
          setState(() {
            _startExercise = false;
          });
          AssetsAudioPlayer.playAndForget(Audio("assets/sounds/completed.wav"));
          assetsAudioPlayer.stop();
        }
        setState(() {
          _elapsedTime = t.tick;
        });
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.title),
        backgroundColor: Color(0xff182a56),
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.exercise.id,
            child: Container(
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: widget.exercise.gif,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.contain,
                )),
          ),
          Expanded(child: SizedBox()),
          CircularPercentIndicator(
            radius: MediaQuery.of(context).size.height * 0.2,
            lineWidth: 5.0,
            percent: _elapsedTime / int.parse(widget.exercise.seconds),
            center: new Text('$_elapsedTime/${widget.exercise.seconds}',
                style: TextStyle(fontSize: 32)),
            progressColor: Colors.green,
          ),
          Expanded(child: SizedBox()),
          RaisedButton(
            child: Text(
              _startExercise ? 'Stop Exercise' : 'Start Exercise',
              style: TextStyle(color: Colors.white),
            ),
            color: Color(0xffe83350),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            onPressed: () async {
              setState(() {
                _startExercise = !_startExercise;
              });
              if (_startExercise) {
                assetsAudioPlayer.open(Audio("assets/sounds/running.mp3"));
              } else {
                assetsAudioPlayer.stop();
              }
              timerFunc();
            },
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
