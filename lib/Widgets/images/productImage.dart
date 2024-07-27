import 'package:cached_network_image/cached_network_image.dart';
import 'package:prishathe/Controller/CourseImagesController.dart';
import 'package:prishathe/Model/ShopModel.dart';
import 'package:prishathe/Widgets/Animation/AnimationLoaderWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prishathe/Model/ShopModel.dart';

import '../../Controller/CourseImagesController.dart';
import '../Appbar/Appbar.dart';
import '../CarouselSlider/RoundedImage.dart';
import '../Curved_Edges/CustomCurvedEdges.dart';

class CourseDecriptionImageDetails extends StatelessWidget {
  const CourseDecriptionImageDetails({
    super.key,
    required this.course,
  });

  final ShopModel course;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseImagesController());
    final images = controller.getAllCourseImages(course);

    return CustomCurveEdgesWidget(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: Center(
                  child: GetBuilder<CourseImagesController>(
                    init: CourseImagesController(),
                    builder: (controller) {
                      final image = controller.selectedCourseImage.value;
                      print("Selected Image URL: $image"); // Debugging line
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: image.isNotEmpty
                            ? CachedNetworkImage(
                          progressIndicatorBuilder:
                              (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Colors.purple,
                              ),
                          imageUrl: image,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error), // Error handling
                        )
                            : Center(
                          child: Lottie.asset(
                              "assets/images/emptyImage.json"),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24,
              right: 0,
              bottom: 30,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => GetBuilder<CourseImagesController>(
                    init: CourseImagesController(),
                    builder: (controller) {
                      final imageSelected =
                          controller.selectedCourseImage.value == images[index];
                      print("Thumbnail URL: ${images[index]}"); // Debugging line
                      return RoundedImage(
                        width: 80,
                        isNetworkImage: true,
                        onPressed: () {
                          controller.selectedCourseImage.value = images[index];
                          controller.update();
                        },
                        backgroundColor: Colors.white,
                        border: Border.all(
                          color: imageSelected
                              ? Colors.purple
                              : Colors.transparent,
                        ),
                        image: images[index],
                        applyImageRadius: true,
                        borderRadius: 80,
                      );
                    },
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemCount: images.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
