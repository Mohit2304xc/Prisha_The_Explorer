import 'package:prishathe/Controller/CartController.dart';
import 'package:prishathe/Widgets/Animation/AnimationLoaderWidget.dart';
import 'package:prishathe/Widgets/BottomNavigation/BottomAddToCart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prishathe/Widgets/Appbar/Appbar.dart';
import 'package:prishathe/Widgets/CarouselSlider/RoundedImage.dart';
import '../../Widgets/CarouselSlider/CoursePrice.dart';
import 'checkOut.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(24),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const CheckoutScreen());
                },
                child: Obx(() =>
                    Text("CheckOut £${controller.totalCartPrice.value}")),
              ),
            ),
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 1,
        title: Text(
          "Cart",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: Colors.white),
        ),
        onPressed: () {
          Get.back();
        },
      ),
      body: Obx(
        () {
          final emptyCart = AnimationLoaderWidget(
            text: 'Oops! Your Cart is empty',
            actionText: "Let's fill it.",
            animation:
                'assets/images/success/lady-adding-product-in-cart-animation.json',
            showAction: true,
            onActionPressed: () => Get.back(),
          );
          if (controller.cartItems.isEmpty) {
            return emptyCart;
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(24),
                child: CartItems(showAddRemoveButton: true,),
              ),
            );
          }
        },
      ),
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    required this.showAddRemoveButton,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, index) => Obx(() {
                final item = controller.cartItems[index];
                return Column(
                  children: [
                    Row(
                      children: [
                        RoundedImage(
                          width: 60,
                          height: 60,
                          isNetworkImage: true,
                          backgroundColor: Colors.white,
                          image: item.image ?? '',
                          applyImageRadius: true,
                          borderRadius: 16,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                item.title,
                                style:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                              if (showAddRemoveButton)
                                AddToCart(
                                  quantity: item.quantity,
                                  add: () => controller.addOneItemToCart(item),
                                  remove: () =>
                                      controller.removeOneItemToCart(item),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        CoursePriceText(
                            price: (item.price * item.quantity)
                                .toStringAsFixed(1)),
                      ],
                    ),
                  ],
                );
              }),
          separatorBuilder: (_, __) => const SizedBox(height: 32),
          itemCount: controller.cartItems.length),
    );
  }
}
