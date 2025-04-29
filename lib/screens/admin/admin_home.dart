import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../providers/order_provider.dart';
import 'order_management.dart';
import '../../models/order.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    
    return Scaffold(
      appBar: const CustomAppBar(title: 'Dashboard Admin', showBackButton: false),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildStatCard(
                  context,
                  'Total Pesanan',
                  orderProvider.orders.length.toString(),
                  Colors.blue,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  context,
                  'Pesanan Baru',
                  orderProvider.orders
                      .where((order) => order.status == 'pending')
                      .length
                      .toString(),
                  Colors.orange,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildStatCard(
                  context,
                  'Diproses',
                  orderProvider.orders
                      .where((order) => order.status == 'processing')
                      .length
                      .toString(),
                  Colors.blue,
                ),
                const SizedBox(width: 16),
                _buildStatCard(
                  context,
                  'Selesai',
                  orderProvider.orders
                      .where((order) => order.status == 'completed')
                      .length
                      .toString(),
                  Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Pesanan Baru'),
                      Tab(text: 'Diproses'),
                      Tab(text: 'Selesai'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildOrderList(
                          context,
                          orderProvider.orders
                              .where((order) => order.status == 'pending')
                              .toList(),
                        ),
                        _buildOrderList(
                          context,
                          orderProvider.orders
                              .where((order) => order.status == 'processing')
                              .toList(),
                        ),
                        _buildOrderList(
                          context,
                          orderProvider.orders
                              .where((order) => order.status == 'completed')
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke manajemen layanan
        },
        child: const Icon(Icons.settings),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Pengguna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            // Navigasi ke manajemen pengguna
          } else if (index == 2) {
            // Navigasi ke profil admin
          }
        },
      ),
    );
  }

  Widget _buildStatCard(
      BuildContext context, String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, List<Order> orders) {
    return orders.isEmpty
        ? const Center(child: Text('Tidak ada pesanan'))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                child: ListTile(
                  title: Text('Order #${order.id}'),
                  subtitle: Text(order.customerName),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderManagementScreen(
                          order: order,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
