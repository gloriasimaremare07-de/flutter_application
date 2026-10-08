import 'package:flutter/material.dart';
import 'package:katalog_produk/models/product.dart';
import 'package:katalog_produk/utils/format.dart';

class ProdukDetailPage extends StatefulWidget {
  final Product produk;

  /// Dipanggil setiap kali tombol "Tambah ke Keranjang" ditekan.
  final VoidCallback onTambahKeranjang;

  const ProdukDetailPage({
    super.key,
    required this.produk,
    required this.onTambahKeranjang,
  });

  @override
  State<ProdukDetailPage> createState() => _ProdukDetailPageState();
}

class _ProdukDetailPageState extends State<ProdukDetailPage> {
  int _ditambahkan = 0; // jumlah yang sudah ditambahkan dari halaman ini

  void _tambah() {
    widget.onTambahKeranjang();
    setState(() {
      _ditambahkan++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.produk.nama} ditambahkan ke keranjang'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.produk;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Produk')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ), // BoxDecoration
              child: Icon(p.ikon, size: 96, color: Colors.deepPurple),
            ), // Container
            const SizedBox(height: 16),
            Text(
              p.nama,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ), // Text
            const SizedBox(height: 8),
            Text(
              formatRupiah(p.harga),
              style: const TextStyle(fontSize: 20, color: Colors.deepPurple),
            ), // Text
            const SizedBox(height: 12),
            Text(p.deskripsi, style: const TextStyle(color: Colors.grey)),
            const Spacer(),
            if (_ditambahkan > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text('Sudah ditambahkan $_ditambahkan kali'),
              ), // Padding
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _tambah,
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Tambah ke Keranjang'),
              ), // ElevatedButton.icon
            ), // SizedBox
          ],
        ), // Column
      ), // Padding
    ); // Scaffold
  }
}
