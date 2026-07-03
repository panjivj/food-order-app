import 'package:flutter/material.dart';

void main() => runApp(const FoodOrderApp());

String rupiah(int value) {
  final digits = value.toString();
  final result = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) result.write('.');
    result.write(digits[i]);
  }
  return 'Rp $result';
}

class FoodOrderApp extends StatelessWidget {
  const FoodOrderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pemesanan Makanan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const MenuPage(),
    );
  }
}

class FoodItem {
  const FoodItem({required this.name, required this.price, required this.icon});

  final String name;
  final int price;
  final IconData icon;
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final menu = const [
    FoodItem(name: 'Nasi Goreng', price: 20000, icon: Icons.rice_bowl),
    FoodItem(name: 'Mie Ayam', price: 15000, icon: Icons.ramen_dining),
    FoodItem(name: 'Sate Ayam', price: 25000, icon: Icons.kebab_dining),
    FoodItem(name: 'Bakso', price: 18000, icon: Icons.soup_kitchen),
    FoodItem(name: 'Es Teh', price: 5000, icon: Icons.local_drink),
    FoodItem(name: 'Es Jeruk', price: 10000, icon: Icons.local_cafe),
  ];

  final List<FoodItem> cart = [];

  int get totalPrice => cart.fold(0, (sum, item) => sum + item.price);

  Future<void> _openCart() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartPage(cart: cart)),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Menu'),
        actions: [
          IconButton(
            tooltip: 'Buka keranjang',
            onPressed: _openCart,
            icon: Badge(
              isLabelVisible: cart.isNotEmpty,
              label: Text('${cart.length}'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            color: Colors.orange.shade50,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih makanan favoritmu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text('Tambahkan menu ke keranjang lalu lakukan checkout.'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                final item = menu[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.shade100,
                      child: Icon(item.icon, color: Colors.deepOrange),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(rupiah(item.price)),
                    trailing: FilledButton(
                      onPressed: () {
                        setState(() => cart.add(item));
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: Text(
                                '${item.name} ditambahkan ke keranjang',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                      },
                      child: const Text('Tambah'),
                    ),
                  ),
                );
              },
            ),
          ),
          const CreatorFooter(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: _openCart,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cart.length} item',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Total: ${rupiah(totalPrice)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreatorFooter extends StatelessWidget {
  const CreatorFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey.shade100,
      child: const Column(
        children: [
          Text(
            'Created By: Panji Jaya Sutra',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Text('NIM: 20220801517', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.cart});

  final List<FoodItem> cart;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int get total => widget.cart.fold(0, (sum, item) => sum + item.price);

  void _removeItem(int index) {
    final item = widget.cart[index];
    setState(() => widget.cart.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} dihapus dari keranjang')),
    );
  }

  Future<void> _clearCart() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Yakin ingin membatalkan semua pesanan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tidak'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      setState(widget.cart.clear);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Semua pesanan dibatalkan')),
        );
      }
    }
  }

  Future<void> _checkout() async {
    final paid = total;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.check_circle, color: Colors.green, size: 52),
        title: const Text('Checkout Berhasil'),
        content: Text(
          'Pesanan berhasil dibuat.\nTotal pembayaran: ${rupiah(paid)}',
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    setState(widget.cart.clear);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keranjang Pesanan')),
      body: Column(
        children: [
          Expanded(
            child: widget.cart.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 72,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Belum ada pesanan',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(item.icon, color: Colors.orange),
                          title: Text(item.name),
                          subtitle: Text(rupiah(item.price)),
                          trailing: IconButton(
                            tooltip: 'Hapus',
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  Text(
                    'Total Bayar: ${rupiah(total)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: widget.cart.isEmpty ? null : _clearCart,
                          icon: const Icon(Icons.delete_sweep),
                          label: const Text('Batalkan'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: widget.cart.isEmpty ? null : _checkout,
                          icon: const Icon(Icons.payment),
                          label: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
