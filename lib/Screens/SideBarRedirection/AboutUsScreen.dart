import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prishathe/Screens/SideBarRedirection/Shop.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          "About Us",
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
                        text: 'Welcome to ',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: 'Prisha The Explorer ',
                        style: TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "where ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "CURIOSITY ",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "leads to ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "DISCOVERY ",
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "and ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "LEARNING ",
                        style: TextStyle(
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "knows ",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    TextSpan(
                        text: "NO BOUNDS!",
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.blue,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Our Vision",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "At Prisha The Explorer we envision a world where every child’s imagination soars, where learning is an exhilarating adventure, and where knowledge is a treasure waiting to be unearthed. Our mission is to inspire young minds to explore, question, and grow through captivating exploratory experiences.",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Explore More",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Get.to(() => ProductPage());
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.green,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Who We Are",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "We are a team of passionate educators, creative storytellers, and dedicated explorers who believe in the power of curiosity to shape the future. Our journey began with a simple idea: that learning should be as exciting as the discoveries themselves.",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Explore More",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Get.to(() => ProductPage());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.deepPurpleAccent,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "What We Do",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Prisha The Explorer takes young learners on thrilling journeys through space and time. Through our engaging videos and interactive content, we bring science, history, and culture to life in a way that’s both entertaining and educational.",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Explore More",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Get.to(() => ProductPage());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.orange,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Why Choose Prisha the Explorer?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Inspiration: We inspire children to dream big, fostering a lifelong love for knowledge and exploration.\n\nEducation: Our content is carefully designed to align with educational standards and promote a deeper understanding of the world around us.\n\nImagination: We believe in the power of imagination and use it to make learning a truly magical experience.\n\nEmpowerment: We empower children to ask questions, seek answers, and become curious, confident learners.",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Explore More",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Get.to(() => ProductPage());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.pink,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Join Our Journey",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "With Prisha The Explorer, the adventure never ends. Join us in sparking the flames of curiosity and shaping the next generation of thinkers, dreamers, and explorers. Together, we’ll discover the wonders of the universe and the richness of our world.\n\nCome explore with us, and let’s ignite the spark of lifelong learning in every child’s heart.\n\nThank you for being a part of our exploration!",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Explore More",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          Get.to(() => ProductPage());
                        },
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
