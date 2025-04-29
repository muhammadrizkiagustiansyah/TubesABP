import 'clothing_item.dart';

class Order {
  final String id;
  final String customerName;
  final String customerPhone;
  final String pickupAddress;
  final String serviceName;
  final String status;
  final String estimatedCompletion;
  final double totalPrice;
  final String paymentMethod;
  final String pickupDate;
  final List<ClothingItem> items;

  Order({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.pickupAddress,
    required this.serviceName,
    required this.status,
    required this.estimatedCompletion,
    required this.totalPrice,
    required this.paymentMethod,
    required this.pickupDate,
    required this.items,
  });

  // Method copyWith untuk memperbarui status atau properti lainnya
  Order copyWith({
    String? id,
    String? customerName,
    String? customerPhone,
    String? pickupAddress,
    String? serviceName,
    String? status,
    String? estimatedCompletion,
    double? totalPrice,
    String? paymentMethod,
    String? pickupDate,
    List<ClothingItem>? items,
  }) {
    return Order(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      serviceName: serviceName ?? this.serviceName,
      status: status ?? this.status,
      estimatedCompletion: estimatedCompletion ?? this.estimatedCompletion,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      pickupDate: pickupDate ?? this.pickupDate,
      items: items ?? this.items,
    );
  }
}
