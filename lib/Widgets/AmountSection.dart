import 'package:prishathe/Controller/CartController.dart';
import 'package:prishathe/Controller/CouponCodeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountSection extends StatefulWidget {
  const AmountSection({super.key});

  @override
  State<AmountSection> createState() => _AmountSectionState();
}

class _AmountSectionState extends State<AmountSection> {
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final couponController = Get.put(CouponCodeController());
    return Obx(() {

      final orderTotal = couponController.isCouponApplied.value
          ? couponController.discountedPrice.value
          : controller.totalCartPrice.value;

      final subTotal = controller.totalCartPrice.value;
      final discount = subTotal - orderTotal;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '£ $subTotal',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '- £ ${discount.abs()}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Total',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '£ $orderTotal',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      );
    });
  }
}



class helper {
  static Widget? checkMultiRecord<T>(
      {required AsyncSnapshot<List<T>> snapshot,
      Widget? loader,
      Widget? error,
      Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      return const Center(child: Text('No Data found!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text("Something Went Wrong."));
    }

    return null;
  }
}
