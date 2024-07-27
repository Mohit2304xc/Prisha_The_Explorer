import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          "Blogs",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFA05BFF),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Welcome to a World of Wonder and Joy",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Step into a magical realm where giggles, learning, and boundless fun collide. Our videos, blogs and products are a treasure trove of captivating tales, vibrant animations, and educational adventures that captivate young minds.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "From heartwarming bedtime stories to enchanting learning journeys, we curate content that sparks imagination and growth. All our work is a gateway to curiosity, encouraging kids to explore, laugh, and learn in a safe online space.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                color: Colors.pinkAccent,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Endless Entertainment, Anytime",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Empower your child with the joy of on-demand entertainment that’s not just entertaining but also enriching. Our videos transport them to colourful worlds where they’re the heroes of their own stories. Join us on this exciting adventure of discovery and laughter. With every click, a new adventure begins, shaping young hearts and minds for a brighter tomorrow",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "From heartwarming bedtime stories to enchanting learning journeys, we curate content that sparks imagination and growth. All our work is a gateway to curiosity, encouraging kids to explore, laugh, and learn in a safe online space.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        color: Colors.green,
                        padding: const EdgeInsets.all(16.0),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Blog',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            BlogEntry(
                              imageUrl: 'assets/images/blogImages/bb3-1024x585.webp',
                              date: '30 Mar',
                              author: 'admin',
                              category: 'Education | Parent',
                              title:
                                  "Prosocial Cartoons: Shaping Children's Behavior",
                            ),
                            BlogEntry(
                              imageUrl: 'assets/images/blogImages/PTE-Blog-Image-2-1024x585.webp',
                              date: '22 Mar',
                              author: 'admin',
                              category: 'Education | Parent',
                              title: 'Family Bonding Through Cartoons',
                            ),
                            BlogEntry(
                              imageUrl: 'assets/images/blogImages/b5-1024x585.webp',
                              date: '19 Mar',
                              author: 'admin',
                              category: 'Education | Parent',
                              title: 'How Cartoons Build Self Esteem in Kids',
                            ),
                            BlogEntry(
                              imageUrl: 'assets/images/blogImages/b4-1024x585.webp',
                              date: '12 Mar',
                              author: 'admin',
                              category: 'Education | Parent',
                              title: 'Impact of Role Models on Kids',
                            ),
                            BlogEntry(
                              imageUrl: 'assets/images/blogImages/b3-1024x585.webp',
                              date: '12 Mar',
                              author: 'admin',
                              category: 'Parent',
                              title: 'Embracing Diversity in Kids',
                            ),
                            BlogEntry(
                              imageUrl: 'assets/images/blogImages/b2-1024x585.webp',
                              date: '08 Mar',
                              author: 'admin',
                              category: 'Education | Parent',
                              title: 'Prisha: Navigating Screen Time',
                            ),
                            BlogEntry(
                              imageUrl: 'assets/images/blogImages/b1-1024x585.webp',
                              date: '05 Mar',
                              author: 'admin',
                              category: 'Education | Parent',
                              title: 'Prisha: Educational Child Development',
                            ),
                          ],
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
    );
  }
}

class BlogEntry extends StatelessWidget {
  final String imageUrl;
  final String date;
  final String author;
  final String category;
  final String title;

  const BlogEntry({super.key, 
    required this.imageUrl,
    required this.date,
    required this.author,
    required this.category,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageUrl, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  author,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Text(
                  category,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
