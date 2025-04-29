import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';
import '../models/clothing_item.dart';
import '../models/service.dart';

class ClothingItemInput extends StatefulWidget {
  final Service selectedService;
  final Function(List<ClothingItem>) onItemsSubmitted;

  const ClothingItemInput({
    super.key,
    required this.selectedService,
    required this.onItemsSubmitted,
  });

  @override
  State<ClothingItemInput> createState() => _ClothingItemInputState();
}

class _ClothingItemInputState extends State<ClothingItemInput> {
  final List<ClothingItem> _selectedItems = [];
  final Map<String, int> _itemQuantities = {};
  final Map<String, double> _itemPrices = {
    'Kemeja': 10000,
    'Kaos': 8000,
    'Celana Panjang': 12000,
    'Celana Pendek': 10000,
    'Jaket': 15000,
    'Mantel': 25000,
    'Blazer': 20000,
    'Jas': 30000,
    'Sepatu': 25000,
    'Karpet Kecil': 30000,
    'Karpet Besar': 50000,
    'Bedcover Single': 35000,
    'Bedcover Double': 45000,
    'Sprei': 20000,
    'Selimut': 25000,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Input Pakaian'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Pilih Jenis Pakaian:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Menghilangkan penggunaan toList()
                ..._itemPrices.entries.map((item) {
                  return _buildClothingItemCard(item.key, item.value);
                }),
                const SizedBox(height: 16),
                if (_selectedItems.isNotEmpty) ...[
                  const Text(
                    'Pakaian Dipilih:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Menghilangkan penggunaan toList()
                  ..._selectedItems.map((item) {
                    return ListTile(
                      title: Text('${item.quantity}x ${item.name}'),
                      subtitle: Text('Rp ${item.price} per item'),
                      trailing: Text('Rp ${item.quantity * item.price}'),
                      leading: IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          _removeItem(item);
                        },
                      ),
                    );
                  }),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rp ${_calculateTotal()}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (_selectedItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  widget.onItemsSubmitted(_selectedItems);
                  Navigator.pop(context);
                },
                child: const Text('SIMPAN PESANAN'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildClothingItemCard(String itemName, double price) {
    final quantity = _itemQuantities[itemName] ?? 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Rp $price per item'),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: quantity > 0
                      ? () {
                          _updateQuantity(itemName, price, quantity - 1);
                        }
                      : null,
                ),
                Text(quantity.toString()),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _updateQuantity(itemName, price, quantity + 1);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateQuantity(String itemName, double price, int newQuantity) {
    setState(() {
      _itemQuantities[itemName] = newQuantity;

      // Update selected items list
      _selectedItems.removeWhere((item) => item.name == itemName);
      if (newQuantity > 0) {
        _selectedItems.add(ClothingItem(
          id: itemName,
          name: itemName,
          quantity: newQuantity,
          price: price,
        ));
      }
    });
  }

  void _removeItem(ClothingItem item) {
    setState(() {
      _selectedItems.remove(item);
      _itemQuantities[item.name] = 0;
    });
  }

  double _calculateTotal() {
    return _selectedItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }
}
