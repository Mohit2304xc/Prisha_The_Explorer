import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prishathe/Screens/HomePage/HomePage.dart';
import 'package:prishathe/Widgets/API_Connection/API_connection.dart';
import 'package:prishathe/Widgets/SectionHeading.dart';
import '../../Widgets/snackbar/Snackbar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prishathe/Controller/NewproductController.dart';
import '../../Widgets/Validator/Validator.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

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
          "Admin",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListTile(
        leading: const Icon(
          Icons.admin_panel_settings,
          color: Colors.purple,
        ),
        title: const Text("Upload Product"),
        onTap: () {
          Navigator.pop(context);
          Get.to(() => const UploadProductScreen());
        },
      ),
    );
  }
}

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  bool imageLoading = false;
  bool pdfLoading = false;
  bool imagePickerActive = false;
  bool pdfPickerActive = false;
  File? contentFile;
  List<XFile>? image;
  List<String> imageUrls = [];
  String pdfUrl = "";
  int countImage = 0;
  int countPdf = 0;
  final controller = Get.put(NewProductController());

  Future<List<String>?> uploadProductPictures() async {
    if (imagePickerActive) {
      return [
        'Image picker is already active'
      ]; // Return a message if already active
    }

    try {
      setState(() {
        imagePickerActive = true; // Set flag to true when starting
      });

      final images = await ImagePicker().pickMultiImage(
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );

      if (images.isNotEmpty) {
        setState(() {
          imageLoading = true;
        });

        final url = Uri.parse(API.uploadImage);
        var request = http.MultipartRequest('POST', url);

        request.fields["name"] = controller.name.text;

        for (var image in images) {
          request.files
              .add(await http.MultipartFile.fromPath('images[]', image.path));
        }

        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonResponse = json.decode(responseString);

        if (jsonResponse['status'] == 'success') {
          List<String> imageUrls =
              List<String>.from(jsonResponse['image_urls']);
          if (mounted) {
            setState(() {
              this.imageUrls = imageUrls;
              countImage = 0;
              countImage += imageUrls.length;
            });
          }
          SnackBars.SuccessSnackBar(
              title: "Congratulations!",
              message: "Your profile Images are updated successfully");
          return imageUrls;
        } else {
          SnackBars.ErrorSnackBar(
              title: "Error",
              message: jsonResponse['message'] ?? 'Unknown error');
          return [jsonResponse['message']];
        }
      } else {
        return ['No images selected'];
      }
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh", message: "Something went wrong: $e");
      return ['Error: $e'];
    } finally {
      if (mounted) {
        setState(() {
          imageLoading = false;
          imagePickerActive = false; // Reset flag when done
        });
      }
    }
  }

  Future<String?> uploadProductPdf() async {
    if (pdfPickerActive) {
      return 'PDF picker is already active'; // Return a message if already active
    }

    try {
      setState(() {
        pdfPickerActive = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          pdfLoading = true;
        });

        final url = Uri.parse(API.uploadPDF);
        var request = http.MultipartRequest('POST', url);

        request.fields["name"] = controller.name.text;

        var pdfFile = result.files.first;
        request.files
            .add(await http.MultipartFile.fromPath('content', pdfFile.path!));

        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonResponse = json.decode(responseString);

        if (jsonResponse['status'] == 'success') {
          String pdfUrl = jsonResponse['file_path'];
          if (mounted) {
            setState(() {
              this.pdfUrl = pdfUrl;
              countPdf = 0;
              countPdf++;
            });
          }
          SnackBars.SuccessSnackBar(
              title: "Congratulations!",
              message: "Your PDF file is uploaded successfully");
          return pdfUrl;
        } else {
          SnackBars.ErrorSnackBar(
              title: "Error",
              message: jsonResponse['message'] ?? 'Unknown error');
          return jsonResponse['message'];
        }
      } else {
        return 'No PDF selected';
      }
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh", message: "Something went wrong: $e");
      return 'Error: $e';
    } finally {
      if (mounted) {
        setState(() {
          pdfLoading = false;
          pdfPickerActive = false;
        });
      }
    }
  }

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
          "New Product",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
            onPressed: () {
              Get.to(() => ProductDetail(name: controller.name.text));
            },
            child: const Text("Next")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller.name,
                validator: (value) =>
                    Validators.validateEmptyText("Name", value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: "Name", prefixIcon: Icon(Icons.type_specimen)),
              ),
              const SizedBox(
                height: 16,
              ),
              Text("$countPdf pdfs are uploaded"),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    uploadProductPdf();
                  },
                  child: const Text("Upload PDF"),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text("$countImage images are uploaded"),
              const SizedBox(height: 20),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    uploadProductPictures();
                  },
                  child: const Text("Upload Images"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    countImage = 0;
    countPdf = 0;
    super.dispose();
  }
}


class ProductDetail extends StatelessWidget {
  ProductDetail({super.key, required this.name});

  final String name;
  final controller = Get.put(NewProductController());

  Future<void> uploadProduct(String name, List<String> category) async {
    try {
      print('Categories to upload: ${category.toList()}'); // Debug print

      final url = Uri.parse(API.upload);
      var request = http.MultipartRequest('POST', url);

      request.fields["name"] = name;
      request.fields["type"] = controller.type.text;
      request.fields["original_price"] = controller.originalPrice.text;
      request.fields["sale_price"] = controller.salePrice.text;
      request.fields["description"] = controller.description.text;
      request.fields["category"] = json.encode(category); // Encode as JSON

      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonResponse = json.decode(responseString);

      if (jsonResponse['status'] == 'success') {
        SnackBars.SuccessSnackBar(
            title: "Congratulations!",
            message: "Your product has been uploaded successfully");
      } else {
        SnackBars.ErrorSnackBar(
            title: "Error",
            message: jsonResponse['message'] ?? 'Unknown error');
      }
    } catch (e) {
      SnackBars.ErrorSnackBar(title: "Oh", message: "Something went wrong: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    RxList<String> category = <String>[].obs;

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
          "New Product",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
            onPressed: () {
              print('Current categories: ${category.toList()}'); // Debug print
              uploadProduct(name, category.toList());
              Get.to(const AdminScreen());
            },
            child: const Text("Submit")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.signupFormKey,
            child: Column(
              children: [
                TextFormField(
                  controller: controller.type,
                  validator: (value) =>
                      Validators.validateEmptyText("Type", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "Type", prefixIcon: Icon(Icons.type_specimen)),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.originalPrice,
                  validator: (value) =>
                      Validators.validateEmptyText("Original Price", value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "Original Price",
                    prefixIcon: Icon(FontAwesomeIcons.moneyBill1),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.salePrice,
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "Sale Price",
                    prefixIcon: Icon(FontAwesomeIcons.moneyBill1),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: controller.description,
                  validator: (value) =>
                      Validators.validateEmptyText("Description", value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    prefixIcon: Icon(Iconsax.money),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SectionHeading(
                  title: "Category",
                  showActionButton: false,
                ),
                const SizedBox(
                  height: 16,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryChip(
                        label: "All",
                        onTap: () {
                          if (!category.contains("All")) {
                            category.add("All");
                            print(category); // Debug print
                          }
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryChip(
                        label: "Books",
                        onTap: () {
                          if (!category.contains("Books")) {
                            category.add("Books");
                            print(category); // Debug print
                          }
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryChip(
                        label: "Flash Cards",
                        onTap: () {
                          if (!category.contains("Flash Cards")) {
                            category.add("Flash Cards");
                            print(category); // Debug print
                          }
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryChip(
                        label: "Free",
                        onTap: () {
                          if (!category.contains("Free")) {
                            category.add("Free");
                            print(category); // Debug print
                          }
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryChip(
                        label: "Premium",
                        onTap: () {
                          if (!category.contains("Premium")) {
                            category.add("Premium");
                            print(category); // Debug print
                          }
                        },
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CategoryChip(
                        label: "T-Shirts",
                        onTap: () {
                          if (!category.contains("T-Shirts")) {
                            category.add("T-Shirts");
                            print(category); // Debug print
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Obx(() => Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: category
                      .map((c) => Chip(
                    label: Text(c),
                    onDeleted: () {
                      category.remove(c);
                    },
                  ))
                      .toList(),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    controller.type.clear();
    controller.originalPrice.clear();
    controller.salePrice.clear();
    controller.description.clear();
    super.key;
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CategoryChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
