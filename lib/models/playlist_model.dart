
import 'song_model.dart';

class PlayList{
  final String title;
  final List<Song> song;
  final String imageUrl;

  PlayList({required this.title, required this.song, required this.imageUrl});

  static List<PlayList> playlists=[
    PlayList(title: "bade to", song: Song.songs, imageUrl: "assets/image/download.jpg"),
    PlayList(title: "hichi namond azam", song: Song.songs, imageUrl: "assets/image/Hichi_Namoond_Azam.jpg"),
    PlayList(title: "otagh abi", song: Song.songs, imageUrl: "assets/image/kaveh_afagh_otaghe_abi.jpg")

  ];
}