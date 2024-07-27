import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:prishathe/Controller/CartController.dart';
import 'package:prishathe/Widgets/Circular_container/RoundedContainer.dart';
import 'package:prishathe/Widgets/SectionHeading.dart';
import '../../Controller/ShopController.dart';
import '../../Model/ShopModel.dart';
import '../../Widgets/snackbar/Snackbar.dart';
import '../Cart.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShopController());

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
          "Shop",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => const CartScreen()),
            icon: const Icon(
              Iconsax.shopping_bag,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.category
                    .map((category) => CategoryButton(category: category.name))
                    .toList(),
              ),
            );
          }),
          Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.filteredProducts.length,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        mainAxisExtent: 288,
                      ),
                      itemBuilder: (context, index) {
                        return ProductCard(
                            product: controller.filteredProducts[index]);
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String category;

  const CategoryButton({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = ShopController.instance;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 150,
        child: ElevatedButton(
          onPressed: () {
            controller.filterProductsByCategory(category);
          },
          child: Text(category),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ShopModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final hasSalePrice = product.salePrice != " ";
    final cartController = Get.put(CartController());
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailPage(product: product));
      },
      child: SizedBox(
        width: 100,
        height: 100,
        child: Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  product.images.isNotEmpty ? product.images[0] : '',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: hasSalePrice,
                      child: Text(
                        '£${product.salePrice}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ),
                    Visibility(
                      visible: hasSalePrice,
                      child: const SizedBox(
                        width: 20,
                      ),
                    ),
                    Text(
                      '£${product.originalPrice}',
                      style: hasSalePrice
                          ? const TextStyle(
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                            )
                          : const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    final cartItem =
                        cartController.convertToCartItem(product, 1);
                    cartController.addOneItemToCart(cartItem);
                    SnackBars.customToast(
                        message: 'Course has been Added to Cart');
                  },
                  child: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatefulWidget {
  final ShopModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: PageView.builder(
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return RoundedContainer(
                          child: Image.network(product.images[index]),
                        );
                      },
                      onPageChanged: (index) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 80, // Adjust height for thumbnails
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: 80, // Thumbnail width
                            height: 80, // Thumbnail height
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _currentImageIndex == index
                                    ? Colors.purple
                                    : Colors.transparent,
                                width: 2,
                              ),
                              image: DecorationImage(
                                image: NetworkImage(product.images[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            else
              Container(
                height: 200,
                color: Colors.grey[200],
                child: const Center(
                  child: Text('No Image Available'),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'In Stock',
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '£${product.salePrice}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '£${product.originalPrice}',
                  style: const TextStyle(
                    fontSize: 20,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const SectionHeading(title: "Description", showActionButton: false),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final cartItem = cartController.convertToCartItem(product, 1);
                cartController.addOneItemToCart(cartItem);
                SnackBars.customToast(message: 'Course has been Added to Cart');
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
