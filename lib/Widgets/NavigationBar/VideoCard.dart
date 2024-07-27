import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoCard extends StatelessWidget {
//   final String videoId;
//   final String title;
//   final String description;
//
//   const VideoCard({
//     Key? key,
//     required this.videoId,
//     required this.title,
//     required this.description,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     YoutubePlayerController controller = YoutubePlayerController(
//       initialVideoId: videoId,
//       flags: const YoutubePlayerFlags(
//         mute: false,
//       ),
//     );
//
//     return Card(
//       margin: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           YoutubePlayer(
//             controller: controller,
//             showVideoProgressIndicator: true,
//             progressIndicatorColor: Colors.purple,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               description,
//               style: const TextStyle(
//                 fontSize: 14.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class VideoCard extends StatefulWidget {
  final String videoId;
  final String title;
  final String description;

  const VideoCard({
    Key? key,
    required this.videoId,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
              onReady: () {
                _controller.addListener(() {
                  if (_controller.value.hasError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Error: ${_controller.value.errorCode.toString()}'),
                      ),
                    );
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
