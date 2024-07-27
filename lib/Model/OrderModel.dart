class OrderModel {
  int id;
  String orderCurrency;
  String cartDiscount;
  String postId;
  DateTime postDate;
  String paymentMethod;
  String orderTotal;
  List<String> items;

  OrderModel({
    required this.id,
    required this.postId,
    required this.cartDiscount,
    required this.postDate,
    required this.orderTotal,
    required this.orderCurrency,
    required this.items,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_currency': orderCurrency,
      'cart_discount': cartDiscount.toString(),
      'post_id': postId.toString(),
      'post_date': postDate.toIso8601String(),
      'payment_method': paymentMethod,
      'order_total': orderTotal.toString(),
      'items': items,
    };
  }


  static OrderModel fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      postId: json['post_id'],
      cartDiscount: json['cart_discount'],
      postDate: DateTime.parse(json['post_date']),
      orderTotal: json['order_total'],
      orderCurrency: json['order_currency'],
      paymentMethod: json['payment_method'],
      items: List<String>.from(json['items']),
    );
  }
}
