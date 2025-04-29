class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.address,
  });
}