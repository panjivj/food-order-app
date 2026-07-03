
import 'package:flutter/material.dart';
void main() {
runApp(const FoodOrderApp());
}
class FoodOrderApp extends StatelessWidget {
const FoodOrderApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Pemesanan Makanan',
theme: ThemeData(primarySwatch: Colors.orange),
home: const MenuPage(),
);
}
}
class FoodItem {
final String name;
final int price;
FoodItem({required this.name, required this.price});
}
class MenuPage extends StatefulWidget {
const MenuPage({super.key});
@override
State<MenuPage> createState() => _MenuPageState();
}
class _MenuPageState extends State<MenuPage> {
final List<FoodItem> menu = [
FoodItem(name: "Nasi Goreng", price: 20000),
FoodItem(name: "Mie Ayam", price: 15000),
FoodItem(name: "Sate Ayam", price: 25000),
FoodItem(name: "Bakso", price: 18000),
FoodItem(name: "Es Teh", price: 5000),
FoodItem(name: "Es Jeruk", price: 10000),
];
final List<FoodItem> cart = [];
int get totalPrice {
return cart.fold(0, (sum, item) => sum + item.price);
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text("Daftar Menu"),
backgroundColor: Colors.lightBlue,
actions: [
IconButton(
icon: Stack(
children: [
const Icon(Icons.shopping_cart),
if (cart.isNotEmpty)
Positioned(
right: 0,
child: CircleAvatar(
radius: 8,
backgroundColor: Colors.red,
child: Text(
"${cart.length}",
style: const TextStyle(
fontSize: 10,
color: Colors.white,
),
),
),
),
],
),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (_) => CartPage(cart: cart)),
).then((_) {
setState(() {});
});
},
),
],
),
body: ListView.builder(
itemCount: menu.length,
itemBuilder: (context, index) {
final item = menu[index];
return Card(
margin: const EdgeInsets.all(8),
child: ListTile(
leading: const Icon(Icons.fastfood, color: Colors.orange),
title: Text(item.name),
subtitle: Text("Rp ${item.price}"),
trailing: ElevatedButton(
onPressed: () {
setState(() {
cart.add(item);
});
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text("${item.name} ditambahkan ke keranjang"),
),
);
},
child: const Text("Tambah"),
),
),
);
},
),
bottomNavigationBar: Container(
padding: const EdgeInsets.all(16),
color: Colors.limeAccent,
child: Text(
"Total Keranjang: Rp $totalPrice",
style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
textAlign: TextAlign.center,
),
),
);
}
}
class CartPage extends StatefulWidget {
final List<FoodItem> cart;
const CartPage({super.key, required this.cart});
@override
State<CartPage> createState() => _CartPageState();
}
class _CartPageState extends State<CartPage> {
@override
Widget build(BuildContext context) {
int total = widget.cart.fold(0, (sum, item) => sum + item.price);
return Scaffold(
appBar: AppBar(title: const Text("Keranjang Pesanan")),
body: widget.cart.isEmpty
? const Center(
child: Text("Belum ada pesanan", style: TextStyle(fontSize:
18)),
)
: Column(
children: [
Expanded(
child: ListView.builder(
itemCount: widget.cart.length,
itemBuilder: (context, index) {
final item = widget.cart[index];
return Card(
child: ListTile(
title: Text(item.name),
subtitle: Text("Rp ${item.price}"),
trailing: IconButton(
icon: const Icon(Icons.delete, color: Colors.red),
onPressed: () {
setState(() {
widget.cart.removeAt(index);
});
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text("${item.name} dibatalkan"),
),
);
},
),
),
);
},
),
),
Container(
padding: const EdgeInsets.all(16),
child: Column(
children: [
Text(
"Total Bayar: Rp $total",
style: const TextStyle(
fontSize: 22,
fontWeight: FontWeight.bold,
),
),
const SizedBox(height: 15),
SizedBox(
width: double.infinity,
child: ElevatedButton.icon(
icon: const Icon(Icons.cancel),
label: const Text("Batalkan Semua Pesanan"),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.red,
),
onPressed: () {
showDialog(
context: context,
builder: (_) => AlertDialog(
title: const Text("Konfirmasi"),
content: const Text(
"Yakin ingin membatalkan semua pesanan?",
),
actions: [
TextButton(
onPressed: () {
Navigator.pop(context);
},
child: const Text("Tidak"),
),
TextButton(
onPressed: () {
setState(() {
widget.cart.clear();
});
Navigator.pop(context);
ScaffoldMessenger.of(
context,
).showSnackBar(
const SnackBar(
content: Text(
"Semua pesanan dibatalkan",
),
),
);
},
child: const Text("Ya"),
),
],
),
);
},
),
),
const SizedBox(height: 10),
SizedBox(
width: double.infinity,
child: ElevatedButton.icon(
icon: const Icon(Icons.payment),
label: const Text("Checkout"),
onPressed: widget.cart.isEmpty
? null
: () {
showDialog(
context: context,
builder: (_) => AlertDialog(
title: const Text("Checkout Berhasil"),
content: Text(
"Pesanan berhasil dibuat.\nTotal
pembayaran: Rp $total",
),
actions: [
TextButton(
onPressed: () {
setState(() {
widget.cart.clear();
});
Navigator.pop(context);
Navigator.pop(context);
},
child: const Text("OK"),
),
],
),
);
},
),
),
],
),
),
],
),
);
}
}