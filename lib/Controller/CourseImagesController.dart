import 'package:cached_network_image/cached_network_image.dart';
import 'package:prishathe/Model/ShopModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseImagesController extends GetxController {
  static CourseImagesController get instance => Get.find();

  RxString selectedCourseImage = ''.obs;

  List<String> getAllCourseImages(ShopModel course) {
    List<String> images = [];
    if (course.images.isNotEmpty) {
      selectedCourseImage.value = course.images[0];
      images.addAll(course.images);
    }
    return images;
  }

  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 24 * 2, horizontal: 24),
              child: CachedNetworkImage(
                imageUrl: image,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text("Close"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
