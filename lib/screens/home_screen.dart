import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/models/playlist_model.dart';
import 'package:music_app/models/song_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Song> songs = Song.songs;

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.deepPurple.shade800.withOpacity(0.5),
            Colors.deepPurple.shade200.withOpacity(0.5)
          ])),
      child: Scaffold(
          appBar: _customAppBar(),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: const _CustomNavBar(),
          body: ListView(shrinkWrap: false, children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Enjoy your favorite music",
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Search",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey.shade400),
                            prefix: Icon(
                              Icons.search,
                              color: Colors.green.shade400,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none)),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Trending Music",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "View More",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.27,
                      child: ListView.builder(
                          itemCount: songs.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            Song song = songs[index];
                            return GestureDetector(
                              onTap: () =>
                                  Get.toNamed("/song", arguments: song),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(right: 10),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      width: size.width * 0.45,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                songs[index].coverUrl,
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      height: 50,
                                      width: size.width * 0.37,
                                      margin: EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                songs[index].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color:
                                                            Colors.deepPurple,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                songs[index].description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Icon(
                                            Icons.play_circle,
                                            color: Colors.deepPurple,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PlayList",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.025),
                              ),
                              Text(
                                "View More",
                                style: TextStyle(fontSize: size.height * 0.015),
                              )
                            ],
                          ),
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(top: 20),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: PlayList.playlists.length,
                            itemBuilder: (context, index) {
                              PlayList playlist = PlayList.playlists[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: GestureDetector(
                                  onTap: (){
                                    Get.toNamed("/playlist",arguments: playlist);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                                    height: 75,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              playlist.imageUrl,
                                              fit: BoxFit.cover,
                                            )),
                                        SizedBox(width: size.width*0.05,),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                playlist.title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              Text(
                                                playlist.song.length.toString() +
                                                    " songs",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),

                                        IconButton(onPressed: (){}, icon: Icon(Icons.play_circle,size: size.height*0.045,color: Colors.white,))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        SizedBox(height: size.height*0.01,)
                      ],
                    )
                  ],
                )
              ],
            ),
          ])),
    );
  }
}

class _CustomNavBar extends StatelessWidget {
  const _CustomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.deepPurple.shade800.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "play"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Profile"),
        ]);
  }
}

class _customAppBar extends StatelessWidget with PreferredSizeWidget {
  const _customAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Icon(Icons.my_library_music_outlined),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(56);
}
