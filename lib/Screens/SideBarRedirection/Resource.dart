import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ResourceScreen extends StatelessWidget {
  const ResourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: Colors.white,
        ),
        title: const Text(
          "Resources",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.purple,
        padding: const EdgeInsets.all(16.0),
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Tiny Minds, Big Adventures: Unlocking the Best Online Treasures for Your Preschooler\'s Journey',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Navigating the tender years of early childhood development requires reliable guidance and support. As a parent, fostering your child\'s growth and education is pivotal. Fortunately, numerous online platforms cater to these needs, offering invaluable resources and insights. Here’s a curated list of essential websites tailored for parents with preschoolers and toddlers:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              ResourceCard(
                uri: "https://www.zerotothree.org/",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                title: 'Zero to Three',
                url: 'zerotothree.org',
                description:
                    'Embracing the pivotal stages of early development, Zero to Three is a cornerstone resource. Discover a wealth of information covering parenting, early learning, and health crucial for infants and toddlers.',
              ),
              ResourceCard(
                uri: "https://pbskids.org/",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                title: 'PBS Kids',
                url: 'pbskids.org',
                description:
                    'Engage your child in educational fun with PBS Kids, offering an array of interactive games, videos, and enriching activities. The platform also equips parents with tools to bolster their child’s learning journey.',
              ),
              ResourceCard(
                uri: "https://www.parents.com/",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                title: 'Parenting',
                url: 'parenting.com',
                description:
                    'Exploring an expansive spectrum of parenting topics, Parenting.com serves as a comprehensive guide. Find articles and advice addressing behavior, health, and educational aspects for parents of little ones.',
              ),
              ResourceCard(
                uri: "https://healthychildren.org/English/Pages/default.aspx",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                title: 'HealthyChildren',
                url: 'HealthyChildren.org',
                description:
                    'Delve into expert guidance on child health and development from the American Academy of Pediatrics’ official parenting hub. Gain valuable resources tailored for parents navigating the early years.',
              ),
              ResourceCard(
                uri: "https://www.understood.org/",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                title: 'Understood',
                url: 'Understood.org',
                description:
                'Supporting parents of children with learning and attention issues, Understood.org offers practical resources and empathetic support to navigate developmental challenges effectively.Sesame',
              ),
              ResourceCard(
                uri: "https://www.sesamestreet.org/",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                title: 'Street',
                url: 'sesamestreet.org',
                description:
                'Immerse your child in educational adventures through Sesame Street’s website, brimming with interactive games, videos, and parental resources. Explore topics like emotional development and school readiness.',
              ),
              ResourceCard(
                uri: "https://www.naeyc.org/",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
              title: 'NAEYC ',
                url: 'naeyc.org',
                description:
                'The National Association for the Education of Young Children empowers parents with resources on early childhood education. Find insightful tips and guidance on selecting quality childcare.',
              ),
              ResourceCard(
                uri: "https://www.khanacademy.org/kids",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              title: 'Khan Academy Kids',
                url: 'khanacademy.org/kids',
                description:
                'Khan Academy Kids presents a free educational app offering diverse activities, books, and games designed specifically for early learners. Delight your child while nurturing their foundational skills across subjects.',
              ),
              ResourceCard(
                uri: "https://www.babycenter.com/",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                title: 'BabyCenter',
                url: 'babycenter.com',
                description:
                'From pregnancy to parenting, BabyCenter serves as a comprehensive guide. Explore a plethora of topics catering to parents at various stages of their child’s growth.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ResourceCard extends StatelessWidget {
  final String title;
  final String url, uri;
  final String description;
  final ShapeBorder shape;

  const ResourceCard({super.key, 
    required this.title,
    required this.url,
    required this.description,
    required this.shape,
    required this.uri,
  });

  function(String url) {
    return Link(
      uri: Uri.parse(url),
      target: LinkTarget.blank,
      builder: (context, followLink) {
        return GestureDetector(
          onTap: followLink,
          child: Text(url),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink[100],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: shape,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Link(
                    uri: Uri.parse(
                        uri),
                    target: LinkTarget.blank,
                    builder: (context, followLink) {
                      return GestureDetector(
                          onTap: followLink, child: Text(url,style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
