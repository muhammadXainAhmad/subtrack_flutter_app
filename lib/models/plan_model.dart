class PlanModel {
  final String name;
  final String billingCycle;
  final int price;
  final String currency;

  PlanModel({
    required this.name,
    required this.billingCycle,
    required this.price,
    required this.currency,
  });

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      name: map['name'] as String,
      price: map['price'] as int,
      currency: map['currency'] as String,
      billingCycle: map['billingCycle'] as String,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'billingCycle': billingCycle,
      'price': price,
      'currency': currency,
    };
  }

  @override
  String toString() => "$name - $price $currency";
}
