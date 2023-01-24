class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song(
      {required this.title,
      required this.description,
      required this.url,
      required this.coverUrl});

  static List<Song> songs = [
    Song(title: "Man Raftam", description: "az shanbe", url: "assets/music/Az Shanbe - Man Raftam.mp3", coverUrl: "assets/image/Man Raftam.jpg"),
    Song(title: "bade to", description: "wantons", url: "assets/music/Benji & Koorosh - Bade To (320).mp3", coverUrl: "assets/image/download.jpg"),
    Song(title: " namond azam", description: "az shanbe", url: "assets/music/Hichi Namoond Azam.mp3", coverUrl: "assets/image/Hichi_Namoond_Azam.jpg"),
    Song(title: "otagh abi", description: "kaveh afagh", url: "assets/music/kaveh_afagh_otaghe_abi.mp3", coverUrl: "assets/image/kaveh_afagh_otaghe_abi.jpg"),


  ];
}
