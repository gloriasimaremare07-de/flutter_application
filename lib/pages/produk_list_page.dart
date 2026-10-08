import 'package:flutter/material.dart';
import 'package:katalog_produk/models/product.dart';
import 'package:katalog_produk/pages/produk_detail_page.dart';
import 'package:katalog_produk/pages/tambah_produk_page.dart';
import 'package:katalog_produk/widgets/product_card.dart';

class ProdukListPage extends StatefulWidget {
  const ProdukListPage({super.key});

  @override
  State<ProdukListPage> createState() => _ProdukListPageState();
}

class _ProdukListPageState extends State<ProdukListPage> {
  // State daftar produk (minimal 5 produk awal)
  final List<Product> _produk = [
    const Product(
      nama: 'Kursi Minimalis',
      harga: 350000,
      deskripsi: 'Kursi kayu bergaya minimalis, nyaman untuk ruang tamu.',
      ikon: Icons.chair,
    ),
    const Product(
      nama: 'Meja Kerja Kayu',
      harga: 750000,
      deskripsi: 'Meja kerja dari kayu jati dengan permukaan luas.',
      ikon: Icons.desk,
    ),
    const Product(
      nama: 'Lampu Meja LED',
      harga: 120000,
      deskripsi: 'Lampu LED hemat energi dengan cahaya yang nyaman di mata.',
      ikon: Icons.lightbulb,
    ),
    const Product(
      nama: 'Rak Buku Susun',
      harga: 540000,
      deskripsi: 'Rak buku empat susun, cocok untuk kamar maupun kantor.',
      ikon: Icons.menu_book,
    ),
    const Product(
      nama: 'Sofa Santai',
      harga: 2300000,
      deskripsi: 'Sofa dua dudukan dengan bantalan empuk.',
      ikon: Icons.weekend,
    ),
    const Product(
      nama: 'Tempat Tidur Single',
      harga: 1800000,
      deskripsi: 'Tempat tidur single dengan rangka kayu kokoh.',
      ikon: Icons.bed,
    ),
  ];

  // State jumlah item di keranjang (ditampilkan sebagai badge)
  int _jumlahKeranjang = 0;

  void _tambahKeKeranjang() {
    setState(() {
      _jumlahKeranjang++;
    });
  }

  Future<void> _bukaDetail(Product produk) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdukDetailPage(
          produk: produk,
          onTambahKeranjang: _tambahKeKeranjang,
        ),
      ), // MaterialPageRoute
    ); // Navigator.push
  }

  Future<void> _bukaFormTambah() async {
    final produkBaru = await Navigator.push<Product>(
      context,
      MaterialPageRoute(builder: (context) => const TambahProdukPage()),
    );
    if (produkBaru != null) {
      setState(() {
        _produk.add(produkBaru);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${produkBaru.nama} berhasil ditambahkan')),
      );
    }
  }

  Future<void> _konfirmasiHapus(Product produk) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Produk?'),
          content: Text('"${produk.nama}" akan dihapus dari daftar.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ), // TextButton
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ), // TextButton
          ],
        ); // AlertDialog
      },
    ); // showDialog

    if (yakin == true) {
      setState(() {
        _produk.remove(produk);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${produk.nama} telah dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        actions: [
          // Ikon keranjang + badge angka (Stack + Positioned)
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                const Icon(Icons.shopping_cart, size: 30),
                if (_jumlahKeranjang > 0)
                  Positioned(
                    top: -6,
                    right: -8,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '$_jumlahKeranjang',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ), // TextStyle
                      ), // Text
                    ), // CircleAvatar
                  ), // Positioned
              ],
            ), // Stack
          ), // Padding
        ],
      ), // AppBar
      body: _produk.isEmpty
          ? const Center(child: Text('Belum ada produk. Tekan + untuk menambah.'))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _produk.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1,
              ), // SliverGridDelegateWithFixedCrossAxisCount
              itemBuilder: (context, index) {
                final item = _produk[index];
                return ProductCard(
                  nama: item.nama,
                  harga: item.harga,
                  ikon: item.ikon,
                  onTap: () => _bukaDetail(item),
                  onDelete: () => _konfirmasiHapus(item),
                ); // ProductCard
              },
            ), // GridView.builder
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaFormTambah,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Produk'),
      ), // FloatingActionButton
    ); // Scaffold
  }
}
