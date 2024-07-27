import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

class NewProductController extends GetxController{
  static NewProductController get instance => Get.find();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  final type = TextEditingController();
  final name = TextEditingController();
  final originalPrice = TextEditingController();
  final salePrice = TextEditingController();
  final description = TextEditingController();
  final category = TextEditingController();

  Future<List<ImageFile>> pickImagesUsingImagePicker(bool allowMultiple) async {
    final picker = ImagePicker();
    final List<XFile> xFiles;
    if (allowMultiple) {
      xFiles = await picker.pickMultiImage(maxWidth: 1080, maxHeight: 1080);
    } else {
      xFiles = [];
      final xFile = await picker.pickImage(
          source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
      if (xFile != null) {
        xFiles.add(xFile);
      }
    }
    if (xFiles.isNotEmpty) {
      return xFiles.map<ImageFile>((e) => convertXFileToImageFile(e)).toList();
    }
    return [];
  }

}