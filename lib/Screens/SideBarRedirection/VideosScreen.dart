import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prishathe/Widgets/NavigationBar/VideoCard.dart';


class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> videos = [
      "lIFuJ3hvI0U",
      "bDAU5fSL1Jk",
      "T7CbN6Qas0M",
      "HJKaq7GcJhc",
      "ZSF-PKb60ZU",
      "LgSNwOzzqdU",
      "WusnOtyaOmw",
      "OVFuLa7nZ5k",
      "dPLcGhDgqz4",
      "-QH-JvnxmuA",
      "ZIyM5z2HlM8",
      "__iFvmrsazg",
      "BqNgOAA6JzY",
      "PZx8Ii_c_3M",
      "HWrP9JqIN3c",
      "dGVOxAchKbA",
      "yF__1HGbQrw",
      "wle8B-bAKaw",
      "LzkzY_T8iI0",
      "tL_FqldfwXI",
      "CUUGxgeQGS0",
      "Ll-PeFv89MM",
      "m8b-9xvOcQs",
      "ErThxLxUBt0",
      "nbznxvwtfKo",
      "_4ZCI5BsxLg",
      "WHUqTT2vBWw"
    ];
    List<String> title = [
      "Jingle Bells Songs for Children | Kids Christmas Songs 2023 | Prisha The Explorer {PTE}",
      "English Rhymes For Kids - Allison Camel | Prisha The Explorer {PTE}",
      "Thrills, Chills, and Scares: Halloween Fun with Prisha and Maya | Prisha The Explorer {PTE}",
      "Prisha Sings Alphabet Rhymes & Kids Songs | Prisha The Explorer {PTE}",
      "Prisha Sings Head Shoulders Knees & Toes Nursery Rhymes & Kids Songs | Prisha The Explorer {PTE}",
      "I Am A Little Tea pot - English Nursery Rhymes Songs For Kids | Prisha The Explorer {PTE}",
      "Itsy Bitsy Spider Song | Prisha The Explorer {PTE}",
      "Prisha Sings Old MacDonald Had A Farm | Prisha The Explorer {PTE}",
      "Prisha's Visit to The Magical Garden | Prisha The Explorer {PTE}",
      "Prisha's Pretend Cooking | Prisha The Explorer {PTE}",
      "Prisha's Playdate | Prisha The Explorer {PTE}",
      "Little Prisha's First Trip to London Part 2 | London Trip | Prisha The Explorer {PTE} #trip",
      "Little Prisha's First Trip to London Part 1 | London Trip | Prisha The Explorer {PTE}",
      "Prisha is Rhyming 5 Little Ducks | 5 Little Ducks | Prisha The Explorer {PTE}",
      "Baa-Baa Black sheep with Prisha The Explorer | Prisha The Explorer {PTE}",
      "Space Exploration with Prisha The Explorer | Names of Planets Vocabulary for Kids (Solar System)",
      "Ants Go Marching with Prisha The Explorer (Super Simple Kids English Rhymes){PTE}",
      "Prisha's Visit to Delhi Monuments | Prisha The Explorer {PTE}",
      "Wheels On The Bus Go Round and Round (Full English Nursery Rhyme) With Prisha The Explorer{PTE}",
      "The Baby Shark Song With Prisha The Explorer ( English Subtitles Available){PTE}",
      "Twinkle Twinkle Little Star With Prisha The Explorer {PTE} | Full Version Twinkle Twinkle Song",
      "Happy Song with Prisha The Explorer{PTE}| Action Song for Kids (Children Nursery English Rhymes)",
      "Prisha The Explorer{PTE}& The Bugs Song | Butterfly Ladybug Bumblebee (Preschool Nursery Rhymes)",
      "Twinkle Twinkle Little Star With Prisha The Explorer | Twinkle Twinkle Song (English Subtitle)",
      "Prisha The Explorer Learns Shapes | Best Learning Videos for Toddlers ( Easy Learning for Kids )",
      "Prisha the Explorer Learns her Colours | Prisha The Explorer {PTE}",
      "Prisha The Explorer Learns Numbers | Prisha The Explorer {PTE}",
    ];
    List<String> description = [
      "Join Prisha, the little explorer, as she takes on a musical adventure with Santa Claus. Get ready to sing",
      "Join Prisha, the little explorer, as she takes on a musical adventure of Allison’s Camel. Get ready to sing along and explore the fascinating world.",
      "Join Prisha, the little explorer, as she takes on a musical adventure of Halloween. Get ready to sing along and explore the fascinating world.",
      "Join Prisha, the little explorer, as she takes on a musical adventure! Get ready to sing along and explore the fascinating world. ",
      "Join Prisha, the little explorer, as she takes on a musical adventure!  Get ready to sing along and explore the fascinating world.",
      "Join Prisha, the little explorer, as she takes on a musical adventure of Im Little Teapot. Get ready to sing along and explore the fascinating world",
      "Enjoy Prisha The Explorer’s content while having fun with your kids. Exciting, Fun & Educational videos for kids.",
      "Join Prisha, the little explorer, as she takes on a musical adventure with her rendition of Old MacDonald Had A Farm!  Get ready to sing along and explore the fascinating world of farm animals.",
      "Prisha, visits a magical garden where she meets some lovely friends who talk with her and love her for playing with them. They gave her the best gift of her life.",
      "Join Prisha on a culinary adventure filled with imagination and fun! Pretend Cooking has never been this entertaining. \n#CookingWithPrisha",
      "Playdates are a blast with Prisha! Discover the world of friendship and games in this exciting episode. \n#PlaydateAdventures",
      "Explore London through the eyes of Little Prisha in this thrilling part 2 of her journey! London’s magic awaits. \n#LondonAdventure",
      "Get on an enchanting adventure as Little Prisha explores the wonders of London in part 1 of her unforgettable trip. \n#LondonExploration",
      "Enjoy Prisha The Explorer’s content while having fun with your kids. Exciting, Fun & Educational videos for kids.",
      "Enjoy Prisha The Explorer’s content while having fun with your kids. Exciting, Fun & Educational videos for kids.",
      "Solar System for Kids in English to Learn | Planet Names Vocabulary for Children, Toddler , Baby Enjoy Prisha The Explorer’s content while having fun with your kids",
      "Enjoy Ants Go marching With Prisha the Explorer Have fun while watching the kids educational video, we hope you enjoy Ants Go Marching nursery rhymes collection by Prisha The Explorer.",
      "Check out Prisha’s visit to Delhi monuments . Enjoy Prisha The Explorer’s contents while having fun with your kids.",
      "Get on an enchanting adventure as Little Prisha explores the wonders of London in part 1 of her unforgettable trip. \n#LondonExploration",
      "Baby Shark Nursery Rhymes Collection — Baby Shark Doo Doo Doo Doo  Baby Shark Nursery Rhymes | Funny Baby Songs for Children | Learn English Rhymes By Prisha The Explorer",
      "Hello friends, Check Out The Full Version of Twinkle Twinkle Little Star Song",
      "Let’s sing the Happy Song together !!!! Sing along to this super fun “Happy Song” with your kids; encourage them to clap their hands & sing along with you.",
      "Hello friends, Do you know The Bugs Song? Let’s learn together. Enjoy this Bugs Song video with your kids also.",
      "Hello friends, Let’s Learn Twinkle Twinkle Little Star ( Nursery Rhymes ) Together.",
      "Learn shapes together with Prisha The Explorer. These are the basic shapes – circle, square, rectangle, triangle , ellipse & more You will love learning with Prisha! A fun & interactive way to learn shapes.",
      "Hello Friends, Today I will learn about various colors. Learn vegetable names with color. Would you like to learn with me? Let’s go….",
      "Hello friends, Today I’m gonna learn about numbers. Come along with me in my new journey",
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        title: const Text(
          "Videos",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Join ',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: 'Prisha ',
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text:
                            "on her captivating journey through breathtaking landscapes, vibrant cultures, and ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "exhilarating experiences ",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "around the world.\n Here, you'll find a ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "collection ",
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "of her inspiring ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "video explorations ",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text:
                            " that showcase the beauty, diversity, and wonder of our planet.\n Each  video is a glimpse into the magic of travel, as ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                      text: "Prisha ",
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    TextSpan(
                      text: "takes you along with her on her ",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    TextSpan(
                      text: "extraordinary ",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    TextSpan(
                      text: "adventures. ",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 200, // Set a fixed height for the horizontal ListView
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset("assets/images/Image Thumbnail/Gallery-img-1_650x500-1.png"),
                    const SizedBox(width: 10),
                    Image.asset("assets/images/Image Thumbnail/Gallery-img-2_650x500-2.png"),
                    const SizedBox(width: 10),
                    Image.asset("assets/images/Image Thumbnail/Gallery-img-3_650x500-3.png"),
                  ],
                ),
              ),
            ),
            ListView.builder(
              itemCount: videos.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return VideoCard(
                    videoId: videos[index],
                    title: title[index],
                    description: description[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent = 288,
    required this.itemBuilder,
  });

  final int itemCount;
  final double mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          mainAxisExtent: mainAxisExtent,
        ),
        itemBuilder: itemBuilder);
  }
}
