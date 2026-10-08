import 'package:flutter/material.dart';
import 'package:katalog_produk/pages/produk_list_page.dart';
import 'package:katalog_produk/pages/profil_page.dart';

/// Navigasi tab (BottomNavigationBar): Produk & Profil.
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _tabTerpilih = 0;

  final List<Widget> _halaman = const [
    ProdukListPage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack menjaga state tiap tab (daftar produk & keranjang
      // tidak hilang saat berpindah tab).
      body: IndexedStack(index: _tabTerpilih, children: _halaman),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabTerpilih,
        onTap: (index) {
          setState(() {
            _tabTerpilih = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Produk',
          ), // BottomNavigationBarItem
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ), // BottomNavigationBarItem
        ],
      ), // BottomNavigationBar
    ); // Scaffold
  }
}
