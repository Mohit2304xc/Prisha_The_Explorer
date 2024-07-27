import 'dart:convert';
import 'package:prishathe/Controller/AddressController.dart';
import 'package:prishathe/Controller/CouponCodeController.dart';
import 'package:prishathe/Controller/UserController.dart';
import 'package:prishathe/Model/OrderModel.dart';
import 'package:prishathe/Screens/HomePage/HomePage.dart';
import 'package:prishathe/Widgets/Circular_container/RoundedContainer.dart';
import 'package:prishathe/Widgets/SectionHeading.dart';
import 'package:prishathe/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prishathe/Widgets/Appbar/Appbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../Controller/CartController.dart';
import '../Widgets/API_Connection/API_connection.dart';
import '../Widgets/AmountSection.dart';
import '../Widgets/Animation/FullScreenLoader.dart';
import 'package:http/http.dart' as http;
import 'Cart.dart';
import 'SuccessScreen.dart';
import 'addresssection.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _razorPay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  saveUserRecord(OrderModel order) async {
    try {
      String itemsJson = jsonEncode(order.items);
      var res = await http.post(
        Uri.parse(API.order),
        body: {
          'order_currency': order.orderCurrency,
          'post_id': order.postId.toString(),
          'cart_discount': order.cartDiscount.toString(),
          'post_date': order.postDate.toIso8601String(),
          'payment_method': order.paymentMethod,
          'order_total': order.orderTotal.toString(),
          'items': itemsJson,
        },
      );
      print("Response received: ${res.body}");
      if (res.statusCode == 200) {
        var response = jsonDecode(res.body);
        print(response);
        if (response['success'] == true) {
          SnackBars.SuccessSnackBar(title: 'Order is updated');
        } else {
          SnackBars.ErrorSnackBar(title: 'Error', message: "Please try again later");
        }
      }
    } catch (e) {
      print("Error saving user record: ${e.toString()}");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      final userId = UserController.instance.user.value.id;
      final cartController = CartController.instance;
      final items = CartController.instance.cartItems
          .map((element) => element.title)
          .toList();
      final order = OrderModel(
        postId: userId,
        postDate: DateTime.now(),
        orderCurrency: "GBP",
        paymentMethod: "Razorpay",
        items: items,
        cartDiscount: (cartController.totalCartPrice.value -
            CouponCodeController.instance.discountedPrice.value)
            .toString(),
        orderTotal:
        CouponCodeController.instance.discountedPrice.value.toString(),
        id: 0,
      );

      // Logging before saving user record
      print("Saving user record");
      await saveUserRecord(order);
      cartController.clearCart();
      FullScreenLoader.stopLoading();

      // Logging before navigation
      print("Navigating to SuccessScreen");
      Get.to(
            () =>
            SuccessScreen(
              title: "Payment Success!",
              subTitle: "Your Payment has been done",
              image: "assets/images/success/processing.json",
              onPressed: () => Get.to(() => const HomePageScreen()),
            ),
      );
    } catch (e) {
      print("Error handling payment success: ${e.toString()}");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment failed");
    // Navigate to SuccessScreen indicating failure
    Get.off(() =>
        SuccessScreen(
          title: "Payment Failed!",
          subTitle: "Your Payment has not been completed",
          image: "assets/images/success/payment_failed.json",
          onPressed: () => Get.to(() => const HomePageScreen()),
        ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External wallet payment success");
    SnackBars.SuccessSnackBar(
        title: "Congratulations",
        message: "Payment success"
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final totalAmount = cartController.totalCartPrice.value;
    return Scaffold(
      appBar: AppbarMenu(
        showBackArrow: true,
        opacity: 1,
        title: Text(
          "CheckOut",
          style: Theme
              .of(context)
              .textTheme
              .titleLarge
              ?.apply(color: Colors.white),
        ),
        onPressed: () {
          Get.to(() => const CartScreen());
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () async {
            final controller = AddressController.instance;
            try {
              final userId = UserController.instance.user.value.id;
              final cartController = CartController.instance;
              final items = cartController.cartItems.map((element) => element.title).toList();

              FullScreenLoader.openLoadingDialog('Processing your order', 'assets/images/success/processing.json');

              final order = OrderModel(
                id: 0,
                postId: userId,
                postDate: DateTime.now(),
                orderCurrency: "GBP",
                paymentMethod: "Razorpay",
                items: items,
                cartDiscount: (cartController.totalCartPrice.value - CouponCodeController.instance.discountedPrice.value).toString(),
                orderTotal: CouponCodeController.instance.discountedPrice.value.toString(),
              );

              if (cartController.discountedPrice.value != 0) {
                print(cartController.discountedPrice.value);
                controller.addNewAddresses();
                var options = {
                  'key': 'rzp_test_mehOkKK0aEoCEA',
                  'amount': (totalAmount * 100).toInt(),
                  'name': UserController.instance.user.value.fullName,
                  'description': 'Courses',
                  'timeout': 120,
                  'prefill': {
                    'email': UserController.instance.user.value.email
                  },
                  'currency': 'GBP',
                };
                _razorPay.open(options);
              } else {
                // Directly saving user record and navigating to SuccessScreen
                print("Total is zero, saving user record");
                print(cartController.discountedPrice.value);
                await saveUserRecord(order);
                print("User record saved");

                print("Clearing cart");
                cartController.clearCart();

                FullScreenLoader.stopLoading();

                print("Navigating to SuccessScreen");
                Get.to(() => SuccessScreen(
                  title: "Payment Success!",
                  subTitle: "Your Payment has been done",
                  image: "assets/images/success/Animation - 1721897502839.json",
                  onPressed: () => Get.to(() => const HomePageScreen()),
                ));
              }
            } catch (e) {
              FullScreenLoader.stopLoading();
              SnackBars.ErrorSnackBar(title: 'Oh Snap!', message: e.toString());
            }
          },
          child: const Text("CheckOut"),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const CartItems(showAddRemoveButton: false),
              const SizedBox(
                height: 32,
              ),
              const CouponCode(),
              const SizedBox(
                height: 32,
              ),
              const RoundedContainer(
                height: 160,
                width: double.infinity,
                radius: 10,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AmountSection(),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration:
                BoxDecoration(border: Border.all(color: Colors.purple)),
                height: 450,
                width: double.infinity,
                child: const Column(
                  children: [
                    SectionHeading(
                      title: "Billing Address",
                      showActionButton: false,
                    ),
                    SizedBox(height: 16),
                    AddNewAddressScreen(
                      wantSaveButton: false,
                    ),
                  ],
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
    _razorPay.clear();
    super.dispose();
  }
}

  class CouponCode extends StatefulWidget {
  const CouponCode({
    super.key,
  });

  @override
  State<CouponCode> createState() => _CouponCodeState();
}

class _CouponCodeState extends State<CouponCode> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CouponCodeController());
    final cartController = Get.put(CartController());
    var subTotal = cartController.totalCartPrice.value;
    return RoundedContainer(
      radius: 10,
      width: 400,
      height: 100,
      backgroundColor: Colors.purpleAccent.shade100,
      padding: const EdgeInsets.only(top: 8, right: 8, left: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextFormField(
              controller: controller.couponController,
              decoration: const InputDecoration(
                hintText: 'Have a promo code? Enter here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  final afterDiscount =
                      controller.applyCoupon(context, subTotal);
                  print(afterDiscount);
                  cartController.updateFinalAmount(afterDiscount);
                  controller.updateFinalAmount(afterDiscount);
                });
                SnackBars.SuccessSnackBar(title: 'Coupon has been applied!');
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black.withOpacity(0.5),
                  backgroundColor: Colors.grey,
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                  )),
              child: const Text("Apply"),
            ),
          )
        ],
      ),
    );
  }
}
