import 'package:prishathe/Model/CartModel.dart';
import 'package:prishathe/Model/ShopModel.dart';
import 'package:prishathe/Widgets/snackbar/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/Services/SharedReferences.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxnDouble discountedPrice = RxnDouble();
  RxInt courseQuantityInCart = 0.obs;
  RxList<CartModel> cartItems = <CartModel>[].obs;

  CartController(){
    loadCartItems();
  }

  void addOneItemToCart(CartModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.courseId == item.courseId);
    if(index>=0){
      cartItems[index].quantity +=1;
    } else{
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneItemToCart(CartModel item){
    int index = cartItems.indexWhere((cartItem) => cartItem.courseId == item.courseId);
    if(index >= 0){
      if(cartItems[index].quantity > 1){
        cartItems[index].quantity -= 1;
      } else{
        cartItems[index].quantity == 1 ? removeFromCartDialog(index) : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index){
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are You sure you want to remove this product?',
      onConfirm: (){
        cartItems.removeAt(index);
        updateCart();
        SnackBars.customToast(message: 'Product has been removed from the Cart');
        Get.back();
      },
      onCancel: () => () => Get.back(),
      confirmTextColor: Colors.red,
      cancelTextColor: Colors.grey,
    );
  }

  //Add items to Cart
  void addToCart(ShopModel course) {
    //quantity Check
    if (courseQuantityInCart.value < 1) {
      SnackBars.customToast(message: 'Select Quantity');
      return;
    }
    final selectedCartItems = convertToCartItem(course,courseQuantityInCart.value );
    //check if already added in the cart
    int index = cartItems.indexWhere((cartItem) => cartItem.courseId == selectedCartItems.courseId);

    if(index >= 0){
      cartItems[index].quantity = selectedCartItems.quantity;
    } else{
      cartItems.add(selectedCartItems);
    }

    updateCart();
    SnackBars.customToast(message: 'Your Course has been Added to the Cart');
  }

  //Update Cart values
  void updateCart(){
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void saveCartItems() async {
    final cartItemJson = cartItems.map((item) => item.toJson()).toList();
    await SharedReferences.saveCartItems(cartItemJson);
  }
  // void saveCartItems(){
  //   final cartItemString = cartItems.map((item) => item.toJson()).toList();
  //   SharedReferences.
  //   TLocalStorage.instance().saveData('cartItems',cartItemString);
  // }

  void updateCartTotals(){
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for(var item in cartItems){
      calculatedTotalPrice +=(item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void updateFinalAmount(double discount){
    discountedPrice.value = discount;

  }

  void loadCartItems()async{
    // final cartItemStrings = TLocalStorage.instance().readData<List<dynamic>>('cartItems');
    final cartItemStrings = await SharedReferences.readCartItems();
    if(cartItemStrings != null){
      cartItems.assignAll(cartItemStrings.map((item) => CartModel.fromJson(item)));
      updateCartTotals();
    }
  }

  void clearCart(){
    courseQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }

  int getProductQuantityInCart(String courseId){
    final foundItem = cartItems.where((item) => item.courseId == courseId).fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }



  //Convert CourseModel to cartModel
  CartModel convertToCartItem(ShopModel course, int quantity) {
    final salePrice = double.tryParse(course.salePrice ?? '');
    final price = salePrice != null && salePrice > 0.0 ? salePrice : course.originalPrice;
    return CartModel(
      courseId: course.id,
      quantity: quantity,
      price: double.parse(price.toString()),
      image: course.images[0],
      title: course.name,
    );
  }


  void updateAlreadyAddedCourseCount(ShopModel course){
    courseQuantityInCart.value = getProductQuantityInCart(course.id);
  }
}
