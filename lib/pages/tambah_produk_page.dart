import 'package:flutter/material.dart';
import 'package:katalog_produk/models/product.dart';

/// Halaman form tambah produk. Mengembalikan [Product] lewat Navigator.pop.
class TambahProdukPage extends StatefulWidget {
  const TambahProdukPage({super.key});

  @override
  State<TambahProdukPage> createState() => _TambahProdukPageState();
}

class _TambahProdukPageState extends State<TambahProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _deskripsiController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _hargaController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_formKey.currentState!.validate()) {
      final deskripsi = _deskripsiController.text.trim();
      final produkBaru = Product(
        nama: _namaController.text.trim(),
        harga: int.parse(_hargaController.text.trim()),
        deskripsi: deskripsi.isEmpty
            ? 'Belum ada deskripsi untuk produk ini.'
            : deskripsi,
      );
      Navigator.pop(context, produkBaru);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.label),
                ), // InputDecoration
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama produk wajib diisi';
                  }
                  if (value.trim().length < 3) {
                    return 'Nama produk minimal 3 karakter';
                  }
                  return null;
                },
              ), // TextFormField
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Harga (Rp)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.payments),
                ), // InputDecoration
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga wajib diisi';
                  }
                  final angka = int.tryParse(value.trim());
                  if (angka == null) {
                    return 'Harga harus berupa angka';
                  }
                  if (angka <= 0) {
                    return 'Harga harus lebih dari 0';
                  }
                  return null;
                },
              ), // TextFormField
              const SizedBox(height: 16),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi (opsional)',
                  border: OutlineInputBorder(),
                ), // InputDecoration
              ), // TextFormField
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpan,
                  child: const Text('Simpan Produk'),
                ), // ElevatedButton
              ), // SizedBox
            ],
          ), // Column
        ), // Form
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
