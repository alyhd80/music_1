import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/models/song_model.dart';
import '../widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class SongScreen extends StatefulWidget {
  SongScreen({Key? key}) : super(key: key);

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  Song song = Get.arguments??Song.songs[3];
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse("asset:/${song.url}")),
      AudioSource.uri(Uri.parse("asset:/${song.url}")),
    ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataSteam =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, audioPlayer.durationStream,
          (Duration position, Duration? duration) {
        return SeekBarData(position, duration ?? Duration.zero);
      });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            song.coverUrl,
            fit: BoxFit.cover,
          ),
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0),
                  ],
                  stops: const [
                    0,
                    0.4,
                    0.6
                  ]).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.deepPurple, Colors.deepPurple])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  song.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.04),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  song.description,
                  style: TextStyle(fontSize: size.height * 0.025),
                ),
                SizedBox(
                  height: 20,
                ),

                ///music player
                StreamBuilder<SeekBarData>(
                    stream: _seekBarDataSteam,
                    builder: (context, snapshot) {
                      final positionData = snapshot.data;
                      return SeekBar(
                        position: positionData?.position ?? Duration.zero,
                        duration: positionData?.duration ?? Duration.zero,
                        onChangedEnd: audioPlayer.seek,
                      );
                    }),

                ///player button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<SequenceState?>(
                        stream: audioPlayer.sequenceStateStream,
                        builder: (context, index) {
                          return IconButton(
                              onPressed: audioPlayer.hasPrevious
                                  ? audioPlayer.seekToPrevious
                                  : null,
                              iconSize: 45,
                              icon: Icon(
                                Icons.skip_previous,
                                color: audioPlayer.hasPrevious
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.2),
                              ));
                        }),
                    StreamBuilder<PlayerState>(
                        stream: audioPlayer.playerStateStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final playerState = snapshot.data;
                            final processingState =
                                (playerState! as PlayerState).processingState;

                            if (processingState == ProcessingState.loading ||
                                processingState == ProcessingState.buffering) {
                              return Container(
                                width: 64,
                                height: 64,
                                margin: EdgeInsets.all(10),
                                child: CircularProgressIndicator(),
                              );
                            } else if (!audioPlayer.playing) {
                              return IconButton(
                                  iconSize: 75,
                                  onPressed: audioPlayer.play,
                                  icon: Icon(
                                    Icons.play_circle,
                                    color: Colors.white,
                                  ));
                            } else if (processingState !=
                                ProcessingState.completed) {
                              return IconButton(
                                  iconSize: 75,
                                  onPressed: audioPlayer.pause,
                                  icon: Icon(
                                    Icons.pause_circle,
                                    color: Colors.white,
                                  ));
                            } else {
                              return IconButton(
                                  iconSize: 75,
                                  onPressed: () => audioPlayer.seek(
                                      Duration.zero,
                                      index:
                                          audioPlayer.effectiveIndices!.first),
                                  icon: Icon(
                                    Icons.replay_circle_filled,
                                    color: Colors.white,
                                  ));
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    StreamBuilder<SequenceState?>(
                        stream: audioPlayer.sequenceStateStream,
                        builder: (context, index) {
                          return IconButton(
                              onPressed: audioPlayer.hasNext
                                  ? audioPlayer.seekToNext
                                  : null,
                              iconSize: 45,
                              icon: Icon(
                                Icons.skip_next,
                                color: audioPlayer.hasNext
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.2),
                              ));
                        }),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        iconSize: 35,
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () {},
                        iconSize: 35,
                        icon: Icon(
                          Icons.cloud_download,
                          color: Colors.white,
                        )),

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
