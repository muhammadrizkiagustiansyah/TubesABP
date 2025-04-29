class Service {
  final String id;
  final String name;
  final String description;
  final List<ServiceType> serviceTypes;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.serviceTypes,
  });
}

class ServiceType {
  final String id;
  final String name;
  final String duration;
  final double price;

  ServiceType({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
  });
}
