import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/link.dart';

class ContactInfoApp extends StatelessWidget {
  const ContactInfoApp({super.key});

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
          "Contact Us",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Column(
              children: [
                Lottie.asset('assets/images/contact us.json',
                    width: MediaQuery.of(context).size.width * 0.9),
                // ContactCard(
                //   icon: Icons.phone,
                //   title: 'Call Us 24/7',
                //   contactInfo: '+44 (0) 78670 90363',
                //   url: Uri(scheme: 'tel', path: "+447867090363"),
                // ),
                ContactCard(
                  icon: FontAwesomeIcons.whatsapp,
                  title: 'Whatsapp',
                  contactInfo: '+44 (0) 78670 90363',
                  url: Uri.parse('https://wa.me/447867090363'),
                ),
                ContactCard(
                  icon: Icons.email,
                  title: 'Mail Us 24/7',
                  contactInfo: 'info@prabisha.com',
                  url: Uri(scheme: 'mailto', path: "info@prabisha.com"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePag extends StatelessWidget {
  const MyHomePag({super.key, required this.number});

  final String number;

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = number;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Caller Demo'),
      ),
      body: Center(
        child: Link(
          uri: Uri(scheme: 'tel', path: phoneNumber),
          builder: (context, followLink) {
            return GestureDetector(
              onTap: followLink,
              child: Text(
                phoneNumber,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String contactInfo;
  final Uri url;

  const ContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.contactInfo,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Link(
      uri: url,
      target: LinkTarget.self,
      builder: (context, followLink) => GestureDetector(
        onTap: followLink,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade200, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.pink,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4.0),
              Link(
                uri: url,
                builder: (context, followLink) => GestureDetector(
                  onTap: followLink,
                  child: Text(
                    contactInfo,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
