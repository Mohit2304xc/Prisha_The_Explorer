import 'package:flutter/material.dart';
class CircularContainer extends StatelessWidget {
  const CircularContainer({super.key, required this.image, required this.name});

  final String image,name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          minRadius: 30,
          maxRadius: 50,
          backgroundColor: Colors.black,
          foregroundImage: AssetImage(image),
        ),
        const SizedBox(height: 15),
        Center(child: Text(name,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),)
      ],
    );
  }
}
