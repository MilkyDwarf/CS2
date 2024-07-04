import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'data.dart';

void main() {
  runApp(MaterialApp(
    home: CSGOInterface(),
  ));
}



class CSGOInterface extends StatefulWidget {
  @override
  _CSGOInterfaceState createState() => _CSGOInterfaceState();
}

class _CSGOInterfaceState extends State<CSGOInterface> {
  int _currentMapIndex = 0;
  int _currentGrenadeIndex = 0;
  List<String> _currentVideoUrls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('CS:GO Interface', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          // Map Carousel
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Maps',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              enlargeFactor: 0.5,
              enableInfiniteScroll: false,
              initialPage: 0,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentMapIndex = index;
                });
              },
            ),
            items: mapImages.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.scaleDown,
                        height: 30,
                        width: 50,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Text(
            'Selected Map: ${mapImages[_currentMapIndex].split('/').last.split('.').first}',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),

          // Grenade Types
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Grenades',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: grenadeImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentGrenadeIndex = index;
                      String selectedMap = mapImages[_currentMapIndex].split('/').last.split('.').first;
                      String selectedGrenade = grenadeImages[_currentGrenadeIndex].split('/').last.split('.').first;

                      if (videoUrls[selectedMap] != null && videoUrls[selectedMap]![selectedGrenade] != null) {
                        _currentVideoUrls = videoUrls[selectedMap]![selectedGrenade]!;
                      } else {
                        _currentVideoUrls = [];
                      }
                    });
                  },
                  child: Container(
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: _currentGrenadeIndex == index
                          ? Colors.blueAccent
                          : Colors.grey[800],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        grenadeImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Selected Grenade: ${grenadeImages[_currentGrenadeIndex].split('/').last.split('.').first}',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),

          // Video List
if (_currentVideoUrls.isNotEmpty) ...[
  Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Text(
      'Videos',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ),
  Container(
    height: 220,
    child: ListView(
      scrollDirection: Axis.vertical,
      children: _currentVideoUrls.map((videoUrl) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 11.0),
          child: AspectRatio(
            aspectRatio: 16/9,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: ProgressBarColors(
                playedColor: Colors.blueAccent,
                handleColor: Colors.blueAccent,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  ),
],
        ],
      ),
    ),);
  }
}
