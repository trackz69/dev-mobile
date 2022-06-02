import 'dart:html';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'music.dart';

//@dart=2.9
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicaNils(),
    );
  }
}

class MusicaNils extends StatefulWidget {
  const MusicaNils({Key? key}) : super(key: key);

  @override
  State<MusicaNils> createState() => _MusicaNilsState();
}

List<Music> myMusicaList = [
  Music('You Know', 'Ziak', 'assets/ziok.jpg', 'assets/ziak.mp3'),
  Music(
      'Bande organisée',
      'Sch, Kofs, Jul, Naps, Soso maness, Elams, Solda, Houari',
      'assets/bande.jpg',
      'assets/bande.mp3'),
  Music('A state of Trance', 'Armin', 'assets/album_a_state_of_france.jpg',
      'https://codiceo.fr/mp3/armin.mp3'),
  Music('Civilisation', 'Orelsan', 'assets/orelsan.jpg',
      'https://codiceo.fr/mp3/civilisation.mp3'),
  Music('Racaille de marseille', 'Jean mi du 13', 'assets/jm13.jpg',
      'assets/jm13.mp3'),
  Music('Meuf égale Princesse', 'Kaarism', 'assets/kaarism.jpg',
      'assets/kaarism.mp3'),
];

class _MusicaNilsState extends State<MusicaNils>
    with SingleTickerProviderStateMixin {
  var i = 0;
  late AnimationController _animationController; //animation button

  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  //bool isPlaying = false;

  //late AudioPlayer _player;
  // late AudioCache cache;
  final _player = AudioPlayer();
  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
//_player.seek(newPos);
  }

  Future<void> initSong(String urlSong) async {
    await _player.setAudioSource(AudioSource.uri(Uri.parse(urlSong)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSong(myMusicaList[i].urlSong);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.yellow.shade800,
                Colors.yellow.shade200,
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 48.0,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "MusicaNils",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Ecoute ta musique préférée",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Center(
                    child: Container(
                  child: Image.asset(
                    myMusicaList[i].imagePath, // image path
                    height: 250,
                  ),
                  width: 280.0,
                  height: 280.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                )),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text(
                    myMusicaList[i].title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    myMusicaList[i].singer,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 500.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              slider(),
                              Text(
                                "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  if (i == 0) {
                                    i = 5;
                                  } else {
                                    i--;
                                  }
                                  initSong(myMusicaList[i].urlSong);
                                });
                              },
                              icon: Icon(
                                Icons.skip_previous,
                              ),
                            ),

                            // animation button

                            IconButton(
                                color: Colors.blue[800],
                                iconSize: 62.0,
                                splashColor: Colors.greenAccent,
                                icon: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  progress: _animationController,
                                ),
                                onPressed: () => {
                                      setState(() {
                                        if (!playing) {
                                          _animationController.reverse();
                                          _player.pause();
                                          playing = true;
                                        } else {
                                          playing = false;
                                          _animationController.forward();
                                          _player.play();
                                        }
                                      }),
                                    }),

                            /*
                            IconButton(
                              iconSize: 62.0,
                              color: Colors.blue[800],
                              /*icon: AnimatedIcon(
                                icon: AnimatedIcons.play_pause,
                                progress: _animationController,
                                color: Colors.greenAccent,
                              ),*/
                              onPressed: () {
                                if (!playing) {
                                  //icon:
                                  //AnimatedIcons.play_pause;
                                  _player.play();
                                  //cache.play("musique.mp3");
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                } else {
                                  _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                }
                              },
                              icon: Icon(
                                playBtn,
                              ),
                            ),*/
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.blue,
                              onPressed: () {
                                setState(() {
                                  if (i == 5) {
                                    i = 0;
                                  } else {
                                    i++;
                                  }
                                  initSong(myMusicaList[i].urlSong);
                                });
                              },
                              icon: Icon(
                                Icons.skip_next,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
