import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prishathe/Controller/UserController.dart';
import 'package:prishathe/Screens/SideBarRedirection/ContactUs.dart';
import 'package:prishathe/Screens/SideBarRedirection/Resource.dart';
import 'package:prishathe/Screens/SideBarRedirection/Shop.dart';
import 'package:prishathe/Screens/SideBarRedirection/VideosScreen.dart';
import 'package:prishathe/Screens/SideBarRedirection/admin.dart';
import 'package:prishathe/Screens/SideBarRedirection/blogs.dart';
import 'package:prishathe/Screens/Welcome/welcome_screen.dart';
import 'package:prishathe/Widgets/Services/SharedReferences.dart';
import '../../Screens/HomePage/HomePage.dart';
import '../../Screens/SideBarRedirection/AboutUsScreen.dart';

class NavigationBarScreen extends StatelessWidget {
  const NavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(controller.user.value.fullName),
            accountEmail: Text(controller.user.value.email),
            decoration: const BoxDecoration(color: Colors.purple),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/user.png",
                  height: 90,
                  width: 90,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.houseChimney,
              color: Colors.purple,
            ),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Get.to(const HomePageScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.circleInfo,
              color: Colors.purple,
            ),
            title: const Text("About"),
            onTap: () {
              Navigator.pop(context);
              Get.to(const AboutScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.video,
              color: Colors.purple,
            ),
            title: const Text("Videos"),
            onTap: () {
              Navigator.pop(context);
              Get.to(const VideosScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.store,
              color: Colors.purple,
            ),
            title: const Text("Shop"),
            onTap: () {
              Navigator.pop(context);
              Get.to(const ProductPage());
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.book,
              color: Colors.purple,
            ),
            title: const Text("My Content"),
            onTap: () {
              Navigator.pop(context);
              Get.to(const ProductPage());
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.blogger,
              color: Colors.purple,
            ),
            title: const Text("Blogs"),
            onTap: () {
              Navigator.pop(context);
              Get.to(const BlogsScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.solidFile,
              color: Colors.purple,
            ),
            title: const Text("Resources"),
            onTap: () {
              Navigator.pop(context);
              Get.to(const ResourceScreen());
            },
          ),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.solidAddressBook,
              color: Colors.purple,
            ),
            title: const Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
              Get.to(const ContactInfoApp());
            },
          ),
          Obx(() {
            if (controller.user.value.email == 'info@prabisha.com') {
              return ListTile(
                leading: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.purple,
                ),
                title: const Text("Admin"),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(const AdminScreen());
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(top: 15.0,left: 85,right: 85,bottom: 40),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  SharedReferences.isFirstTimeWrite(true);
                  SharedReferences.removeData("currentUser");
                  Get.to(const WelcomeScreen());
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
