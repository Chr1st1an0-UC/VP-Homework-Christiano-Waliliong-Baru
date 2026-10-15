class MenuItem {
  final String name;
  final double price;
  final int? discountPercent;

  MenuItem({required this.name, required this.price, this.discountPercent,});

// penggunaan clamp dapat dari gemini untuk memastikan bahwa diskonnya tidak lari dari 0-100% agar tidak negatif serta penggunaan round untuk membulatkan harga akhir biar tidak desimal
  int finalPrice() {
    final discount = (discountPercent ?? 0).clamp(0, 100);
    return (price * (1 - discount / 100)).round(); 
  }
}

void main() {
  List<MenuItem> ListMenu = [
    MenuItem(name: 'Nasi Goreng', price: 20000, discountPercent: 10),
    MenuItem(name: 'Es Teh Manis', price: 5000),
    MenuItem(name: 'Ayam Geprek', price: 15000, discountPercent: 20),
    MenuItem(name: 'Kopi Hitam', price: 10000),
    MenuItem(name: 'Mie Goreng Extra', price: 18000, discountPercent: 5),
  ];

// Gemini
  List<String> SemuaNama = ListMenu.map((item) => item.name).toList();
  print('\n1. Semua nama item:');
  print(SemuaNama);

// Gemini
  print('\n2. Item dengan harga di bawah Rp 15.000 (setelah diskon):');
  print(ListMenu.where((item) => item.finalPrice() < 15000).map((item) => item.name).toList());

// Gemini
  int totalHarga = ListMenu.fold(0, (total, item) => total + item.finalPrice());
  print('\n3. Total harga semua item: Rp $totalHarga');
}