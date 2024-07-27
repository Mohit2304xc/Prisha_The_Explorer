import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponCodeController extends GetxController {
  static CouponCodeController get instance => Get.find();

  final TextEditingController couponController = TextEditingController();
  final List<String> validCoupons = ['INTERNAL', 'SAVE10', 'SAVE50'];
  RxBool isCouponApplied = false.obs;
  RxDouble discountedPrice = 0.0.obs;

  double applyCoupon(BuildContext context, double originalPrice) {
    String enteredCoupon = couponController.text.toUpperCase();
    if (validCoupons.contains(enteredCoupon)) {
      isCouponApplied.value = true;
      switch (enteredCoupon) {
        case 'INTERNAL':
          discountedPrice.value = 0.0; // 100% discount
          break;
        case 'SAVE10':
          discountedPrice.value = originalPrice * 0.9; // 10% discount
          break;
        case 'SAVE50':
          discountedPrice.value = originalPrice * 0.5; // 50% discount
          break;
      }
      return discountedPrice.value; // Return the discounted price
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Coupon'),
          content: const Text('The coupon code you entered is not valid.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      throw Exception('Invalid Coupon'); // Throw an exception
    }
  }

  void updateFinalAmount(double discount) {
    discountedPrice.value = discount;
  }
}
