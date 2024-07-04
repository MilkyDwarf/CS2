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
  void initState() {
    super.initState();
    _updateSelectedVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('CS2 Grenade Trainer', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red[800],
        elevation: 0,
      ),
      body: SingleChildScrollView(child: Center( child:  Column(
        children: [
          // Map Carousel
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Карты',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 120,
            child: 
 
                ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: mapImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentMapIndex = index;
                      String selectedMap = mapImages[_currentMapIndex].split('/').last.split('.').first;
                      String selectedGrenade = grenadeImages[_currentGrenadeIndex].split('/').last.split('.').first;

                      if (videoUrls[selectedMap] != null && videoUrls[selectedMap]![selectedGrenade] != null) {
                        _currentVideoUrls = videoUrls[selectedMap]![selectedGrenade]!;
                      } else {
                        _currentVideoUrls = [];
                      }
                      _updateSelectedVideos();
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 121,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: _currentMapIndex == index
                          ? Color.fromARGB(255, 255, 149, 1)
                          : Colors.redAccent,
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
                        mapImages[index],
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
            'Выбрана карта: ${mapImages[_currentMapIndex].split('/').last.split('.').first}',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),

          // Grenade Types
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Гранаты',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ), 
          Container(
            alignment: Alignment.center,
            height: 120,
            child: 
 
                ListView.builder(
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
                    _updateSelectedVideos();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 121,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: _currentGrenadeIndex == index
                          ? Color.fromARGB(255, 255, 149, 1)
                          : Colors.redAccent,
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
            'Выбрана граната: ${grenadeImages[_currentGrenadeIndex].split('/').last.split('.').first}',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),

          // Video List
        
if (_currentVideoUrls.isNotEmpty) ...[
  Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Text(
      'Видео',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ),
  Container(
  height: 220,
  child: ListView.builder(
    key: ValueKey<int>(_currentMapIndex * grenadeImages.length + _currentGrenadeIndex), // Ensure the list updates
    scrollDirection: Axis.vertical,
    itemCount: _currentVideoUrls.length,
    itemBuilder: (context, index) {
      final videoUrl = _currentVideoUrls[index];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 11.0),
        child: AspectRatio(
          aspectRatio: 16 / 9,
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
    },
  ),
),

],
        ],
      ),),
    ),);
    
  }
  void _updateSelectedVideos() {
    String selectedMap = mapImages[_currentMapIndex].split('/').last.split('.').first;
    String selectedGrenade = grenadeImages[_currentGrenadeIndex].split('/').last.split('.').first;

    if (videoUrls.containsKey(selectedMap) && videoUrls[selectedMap]!.containsKey(selectedGrenade)) {
      _currentVideoUrls = videoUrls[selectedMap]![selectedGrenade]!;
    } else {
      _currentVideoUrls = [];
    }
  }
}
