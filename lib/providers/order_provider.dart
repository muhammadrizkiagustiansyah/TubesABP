import 'package:flutter/material.dart';
import '../models/order.dart';
import '../models/service.dart';
import '../models/clothing_item.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [
    Order(
      id: '001',
      customerName: 'John Doe',
      customerPhone: '08123456789',
      pickupAddress: 'Jl. Contoh No. 123, Jakarta',
      serviceName: 'Cuci Kering Lipat',
      status: 'pending',
      estimatedCompletion: '27 April 2023',
      totalPrice: 45000,
      paymentMethod: 'QRIS',
      pickupDate: '26 April 2023',
      items: [
        ClothingItem(
          id: '1',
          name: 'Kemeja',
          quantity: 3,
          price: 10000,
        ),
        ClothingItem(
          id: '2',
          name: 'Celana Jeans',
          quantity: 2,
          price: 15000,
        ),
      ],
    ),
    Order(
      id: '002',
      customerName: 'Jane Smith',
      customerPhone: '08987654321',
      pickupAddress: 'Jl. Contoh No. 456, Jakarta',
      serviceName: 'Cuci Setrika',
      status: 'processing',
      estimatedCompletion: '28 April 2023',
      totalPrice: 60000,
      paymentMethod: 'Transfer Bank',
      pickupDate: '26 April 2023',
      items: [
        ClothingItem(
          id: '3',
          name: 'Jaket',
          quantity: 1,
          price: 20000,
        ),
        ClothingItem(
          id: '4',
          name: 'Bedcover',
          quantity: 1,
          price: 40000,
        ),
      ],
    ),
  ];

  final List<Service> _services = [
    Service(
      id: '1',
      name: 'Cuci Kering Lipat',
      description: 'Pakaian dicuci dan dilipat rapi',
      serviceTypes: [
        ServiceType(
          id: 'regular',
          name: 'Reguler',
          duration: '1 hari',
          price: 10000,
        ),
        ServiceType(
          id: 'express',
          name: 'Express',
          duration: '3 jam',
          price: 15000,
        ),
      ],
    ),
    Service(
      id: '2',
      name: 'Cuci Setrika',
      description: 'Pakaian dicuci dan disetrika rapi',
      serviceTypes: [
        ServiceType(
          id: 'regular',
          name: 'Reguler',
          duration: '1 hari',
          price: 15000,
        ),
        ServiceType(
          id: 'express',
          name: 'Express',
          duration: '3 jam',
          price: 20000,
        ),
      ],
    ),
    Service(
      id: '3',
      name: 'Setrika Saja',
      description: 'Pakaian hanya disetrika',
      serviceTypes: [
        ServiceType(
          id: 'regular',
          name: 'Reguler',
          duration: '1 hari',
          price: 8000,
        ),
        ServiceType(
          id: 'express',
          name: 'Express',
          duration: '3 jam',
          price: 12000,
        ),
      ],
    ),
  ];

  List<Order> get orders => _orders;
  List<Service> get services => _services;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String status) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(status: status);
      notifyListeners();
    }
  }

  void addService(Service service) {
    _services.add(service);
    notifyListeners();
  }

  void updateService(Service updatedService) {
    final index = _services.indexWhere((s) => s.id == updatedService.id);
    if (index != -1) {
      _services[index] = updatedService;
      notifyListeners();
    }
  }
}