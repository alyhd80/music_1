import 'package:flutter/material.dart';
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
  Song song = Song.songs[0];
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    audioPlayer.setAudioSource(ConcatenatingAudioSource(
        children: [AudioSource.uri(Uri.parse("assets:///${song.url}"))]));
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
          StreamBuilder(
              stream: _seekBarDataSteam,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  position: positionData?.duration ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChangedEnd: audioPlayer.seek,
                );
              })
        ],
      ),
    );
  }
}
