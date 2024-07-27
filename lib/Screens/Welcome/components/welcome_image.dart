import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.1), // Spacing from top
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: const Text(
              "WELCOME TO",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.purple),
            ),
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              "PRISHA THE EXPLORER",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.purple),
            ),
          ),
        ),
      ],
    );
  }
}