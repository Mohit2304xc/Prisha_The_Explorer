import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:prishathe/Widgets/Circular_container/CircularContainer.dart';
import 'package:prishathe/Widgets/Circular_container/RoundedContainer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../Widgets/NavigationBar/NavigationBar.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/images/searchbackgroundvideo.mp4')
          ..initialize().then((_) {
            setState(
                () {}); // Ensure the first frame is shown after the video is initialized
          }).catchError((error) {
            // Handle the error here
            print('Error initializing video: $error');
          })
          ..setLooping(true)
          ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationBarScreen(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purpleAccent,
        title: const Text(
          "Home",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for products...',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 15.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Discover the World with\n',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Prisha',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' Your Gateway to\nGlobal Exploration',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              color: Colors.purpleAccent,
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20,bottom: 20),
                    child: Text(
                      "Prisha The Explorer: \nWhere Curiosity Takes Flight",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Hello Friends! I’m Prisha, and I’ve got a secret to share: the entire world is like one big family to me! Just imagine, I zoom around in my cool car, embark on delightful boat adventures, and even take to the skies in my very own airplane. How awesome is that?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "But you know what truly makes this journey special? It’s not just about places; it’s about the thrilling experiences, the incredible discoveries, and the joy of learning. Every twist and turn, every wave and cloud, they’re all a part of my amazing exploration.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Now, here’s the best part – I want YOU and your friends to join me! Can you imagine the excitement as we dive into this captivating journey together? We’ll uncover new places, get to know fascinating things, and oh, the toys! Let’s enjoy the wonderful world of toys waiting to be discovered.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "My lovely friends, spark your curiosity, ignite your sense of wonder, and let’s set sail on this exhilarating adventure with me. Get ready to be amazed, get ready to explore!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.deepPurpleAccent,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Explore the planets with Prisha",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Join Prisha as she gets on her very first space adventure. Our creative and fun video series will ignite your child’s passion for science and the wonders of space. It’s an out-of-this-world way to inspire young minds!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularContainer(
                                  image: "assets/images/mercury.gif",
                                  name: "Mercury"),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularContainer(
                                  image:
                                      "assets/images/Rotating_earth_animated_transparent.gif",
                                  name: "Earth"),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularContainer(
                                  image: "assets/images/Venus_Rotation_Movie.gif",
                                  name: "Venus"),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularContainer(
                                  image: "assets/images/mars.gif", name: "Mars"),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularContainer(
                                  image:
                                      "assets/images/Voyager_Jupiter_Rotation_Movie.gif",
                                  name: "Jupiter"),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularContainer(
                                  image: "assets/images/saturn.gif",
                                  name: "Saturn"),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularContainer(
                                  image: "assets/images/Uranus.gif",
                                  name: "Uranus"),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: CircularContainer(
                                  image: "assets/images/Neptune.gif",
                                  name: "Neptune"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.blueAccent,
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Discover Monumental Adventures!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Prisha is off to explore the world’s most famous monuments, bringing history and culture to life in an exciting and creative video format. It’s the perfect way to inspire kids to learn about iconic landmarks around the globe.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.lightBlueAccent,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Meet Famous Personalities!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Join Prisha as she delves into the lives of renowned personalities in a captivating video series. It’s an educational and entertaining journey that sparks curiosity and knowledge.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10.0,top:10,bottom: 10),
                          child: RoundedContainer(
                            height: 200,
                            width: 150,
                            radius: 10,
                            child:
                                Image.asset("assets/images/Mother-Teresa.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0,top:10,bottom: 10),
                          child: RoundedContainer(
                            height: 200,
                            width: 150,
                            radius: 10,
                            child:
                                Image.asset("assets/images/Nelson-Mandela.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10.0,top:10,bottom: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RoundedContainer(
                            height: 200,
                            width: 150,
                            radius: 10,
                            child: Image.asset(
                                "assets/images/Abraham-Lincoln.png"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:10.0,top:10,bottom: 10),
                          child: RoundedContainer(
                            height: 200,
                            width: 150,
                            radius: 10,
                            child: Image.asset(
                                "assets/images/Albert-Einstein.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.lightGreen,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Prisha is watching new videos and learning everyday",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "This is a fun, creative video about Prisha. The Explorer exploring Monuments for the first time It’s a great way to inspire kids to learn about world’s famous monuments.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedContainer(
                              height: 150,
                              width: 270,
                              child: Link(
                                uri: Uri.parse(
                                    "https://www.youtube.com/watch?v=bDAU5fSL1Jk"),
                                target: LinkTarget.blank,
                                builder: (context, followLink) {
                                  return GestureDetector(
                                    onTap: followLink,
                                    child: Image.asset(
                                        "assets/images/VideoThumbnail/allison-camel-thumbnail.png"),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedContainer(
                              height: 150,
                              width: 270,
                              child: Link(
                                uri: Uri.parse(
                                    "https://www.youtube.com/watch?v=LgSNwOzzqdU"),
                                target: LinkTarget.blank,
                                builder: (context, followLink) {
                                  return GestureDetector(
                                    onTap: followLink,
                                    child: Image.asset(
                                        "assets/images/VideoThumbnail/im-a-little-tea-pot.png.jpeg"),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedContainer(
                              height: 150,
                              width: 270,
                              child: Link(
                                uri: Uri.parse(
                                    "https://www.youtube.com/watch?v=CUUGxgeQGS0"),
                                target: LinkTarget.blank,
                                builder: (context, followLink) {
                                  return GestureDetector(
                                    onTap: followLink,
                                    child: Image.asset(
                                        "assets/images/VideoThumbnail/twinkle-twinkle-little-star-thumbnail.jpeg"),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.deepOrangeAccent,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Dive into Stories and Rhymes!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Prisha loves storytelling! Watch as she immerses herself in engaging story videos and catchy rhymes, making learning fun and interactive.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                                "assets/images/Image Thumbnail/Baa-Baa-black-sheep.png.webp"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                                "assets/images/Image Thumbnail/Old-mac-donald.png.webp"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                                "assets/images/Image Thumbnail/Twinkle-Twinkle.png.webp"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.pinkAccent,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Explore the World of Books!",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Prisha The Explorer takes your child on a reading adventure like no other. Discover the joy of learning through books, igniting a lifelong love for reading.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                                "assets/images/Image Thumbnail/Beauty-and-the-Beast.png.webp"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                                "assets/images/Image Thumbnail/Cinderella.png.webp"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                                "assets/images/Image Thumbnail/Rapunzel.png.webp"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: CupertinoColors.systemYellow,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Prisha is loves to learn new things",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Prisha’s passion for learning fuels her curiosity, driving her to eagerly embrace new knowledge and experiences with boundless enthusiasm.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedContainer(
                              width: 200,
                              height: 200,
                              child: Image.asset(
                                  "assets/images/Image Thumbnail/Screenshot-2023-11-24-162957.png.webp"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedContainer(
                              width: 200,
                              height: 200,
                              child: Image.asset(
                                  "assets/images/Image Thumbnail/Screenshot-2023-11-25-143145-1.png.webp"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedContainer(
                              width: 200,
                              height: 200,
                              child: Image.asset(
                                  "assets/images/Image Thumbnail/Screenshot-2023-11-25-152808-1.png.webp"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RoundedContainer(
                              width: 200,
                              height: 200,
                              child: Image.asset(
                                  "assets/images/Image Thumbnail/Screenshot-2023-11-25-153122-1.png.webp"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'At ',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: 'Prisha The Explorer',
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text:
                            ", we're not just a website; we're a gateway to endless ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "learning and fun ",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "Join us on our exciting ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "adventures ",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "and inspire your ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "child's curiosity ",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "today!",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.purple,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Our Recent Videos",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Link(
                              uri: Uri.parse(
                                  "https://www.youtube.com/watch?v=bDAU5fSL1Jk"),
                              target: LinkTarget.blank,
                              builder: (context, followLink) {
                                return GestureDetector(
                                  onTap: followLink,
                                  child: Image.asset(
                                      "assets/images/VideoThumbnail/allison-camel-thumbnail.png"),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Link(
                              uri: Uri.parse(
                                  "https://www.youtube.com/watch?v=LgSNwOzzqdU"),
                              target: LinkTarget.blank,
                              builder: (context, followLink) {
                                return GestureDetector(
                                  onTap: followLink,
                                  child: Image.asset(
                                      "assets/images/VideoThumbnail/im-a-little-tea-pot.png.jpeg"),
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Link(
                              uri: Uri.parse(
                                  "https://www.youtube.com/watch?v=CUUGxgeQGS0"),
                              target: LinkTarget.blank,
                              builder: (context, followLink) {
                                return GestureDetector(
                                  onTap: followLink,
                                  child: Image.asset(
                                      "assets/images/VideoThumbnail/twinkle-twinkle-little-star-thumbnail.jpeg"),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Happy Clients",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "WHAT PEOPLE SAY!",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "The content of Prisha The Explorer is really good and kids have fun while watching the videos.",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class youtubeVideoPlayer extends StatefulWidget {
  const youtubeVideoPlayer({super.key});

  @override
  State<youtubeVideoPlayer> createState() => _youtubeVideoPlayerState();
}

class _youtubeVideoPlayerState extends State<youtubeVideoPlayer> {
  final videoUrl = "https://www.youtube.com/watch?v=YMx8Bbev6T4";
  late YoutubePlayerController controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoUrl);
    controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
          )
        ],
      ),
    );
  }
}
